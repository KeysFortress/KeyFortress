import android.os.CancellationSignal
import android.service.autofill.AutofillService
import android.service.autofill.FillCallback
import android.service.autofill.FillRequest
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

class AutofillService : AutofillService() {

    private val CHANNEL = "com.example.autofill/data"

    override fun onFillRequest(request: FillRequest, cancellationSignal: CancellationSignal, callback: FillCallback) {
        // Extract necessary data from the request and send it to Flutter for suggestions
        val data = fetchDataForSuggestions(request)
        sendDataToFlutter(data)
    }

    private fun fetchDataForSuggestions(request: FillRequest): Map<String, String> {
        // Implement logic to fetch data based on the request
        // For demonstration purposes, let's assume we have some hardcoded data
        val data = mapOf(
            "username" to "john_doe",
            "password" to "secure_password"
        )
        return data
    }

    private fun sendDataToFlutter(data: Map<String, String>) {
        // Initialize method channel
        val flutterActivity = getCurrentFlutterActivity()
        val methodChannel = MethodChannel(flutterActivity!!.flutterEngine!!.dartExecutor, CHANNEL)

        // Send data to Flutter
        methodChannel.invokeMethod("receiveData", data)
    }

    private fun getCurrentFlutterActivity(): FlutterActivity? {
        return FlutterActivity.currentActivity as? FlutterActivity
    }
}
