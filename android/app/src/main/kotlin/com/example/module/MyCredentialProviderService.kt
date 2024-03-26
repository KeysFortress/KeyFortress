import android.app.PendingIntent
import android.content.Intent
import android.os.CancellationSignal
import androidx.security.identity




class MyCredentialProviderService : CredentialService() {

    private val PERSONAL_ACCOUNT_ID = "personal_account_id"
    private val FAMILY_ACCOUNT_ID = "family_account_id"
    private val CREATE_PASSKEY_INTENT = "your.package.name.ACTION_CREATE_PASSKEY"
    private val PACKAGE_NAME = "your.package.name"
    private val EXTRA_KEY_ACCOUNT_ID = "account_id"
    private val UNIQUE_REQ_CODE = 12345 // Example request code, replace with your own


    override fun onBeginCreateCredentialRequest(
        request: BeginCreateCredentialRequest,
        cancellationSignal: CancellationSignal,
        callback: OutcomeReceiver<BeginCreateCredentialResponse, CreateCredentialException>
    ) {
        val response: BeginCreateCredentialResponse? = processCreateCredentialRequest(request)
        if (response != null) {
            callback.onResult(response)
        } else {
            callback.onError(CreateCredentialUnknownException())
        }
    }

    private fun processCreateCredentialRequest(request: BeginCreateCredentialRequest): BeginCreateCredentialResponse? {
        when (request) {
            is BeginCreatePublicKeyCredentialRequest -> {
                // Request is passkey type
                return handleCreatePasskeyQuery(request)
            }
        }
        // Request not supported
        return null
    }

    private fun handleCreatePasskeyQuery(request: BeginCreatePublicKeyCredentialRequest): BeginCreateCredentialResponse {
        // Adding two create entries - one for storing credentials to the 'Personal'
        // account, and one for storing them to the 'Family' account. These
        // accounts are local to this sample app only.
        val createEntries: MutableList<CreateEntry> = mutableListOf()
        createEntries.add(
            CreateEntry(
                PERSONAL_ACCOUNT_ID,
                createNewPendingIntent(PERSONAL_ACCOUNT_ID, CREATE_PASSKEY_INTENT)
            )
        )

        createEntries.add(
            CreateEntry(
                FAMILY_ACCOUNT_ID,
                createNewPendingIntent(FAMILY_ACCOUNT_ID, CREATE_PASSKEY_INTENT)
            )
        )

        return BeginCreateCredentialResponse(createEntries)
    }

    private fun createNewPendingIntent(accountId: String, action: String): PendingIntent {
        val intent = Intent(action).setPackage(PACKAGE_NAME)

        // Add your local account ID as an extra to the intent, so that when
        // user selects this entry, the credential can be saved to this
        // account
        intent.putExtra(EXTRA_KEY_ACCOUNT_ID, accountId)

        return PendingIntent.getActivity(
            applicationContext, UNIQUE_REQ_CODE,
            intent, (
                    PendingIntent.FLAG_MUTABLE
                            or PendingIntent.FLAG_UPDATE_CURRENT
                    )
        )
    }
}
