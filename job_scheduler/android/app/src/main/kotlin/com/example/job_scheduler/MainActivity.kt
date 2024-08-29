package com.example.job_scheduler
//
//import android.os.Handler
//import android.os.Looper
//import android.widget.Toast
//import io.flutter.embedding.android.FlutterActivity
//import io.flutter.embedding.engine.FlutterEngine
//import io.flutter.plugin.common.MethodChannel
//
//class MainActivity : FlutterActivity() {
//    private val channelName = "job_scheduler"
//    private lateinit var handler: Handler
//    private lateinit var runnable: Runnable
//
//    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
//        super.configureFlutterEngine(flutterEngine)
//
//        handler = Handler(Looper.getMainLooper())
//
//        val method = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelName)
//
//        method.setMethodCallHandler { call, result ->
//            if (call.method == "meetingName") {
//                val meetingName = call.argument<String>("meetingName")
//                if (meetingName != null) {
//                    startRepeatingToast(meetingName)
//                    result.success(meetingName)
//                } else {
//                    result.error("INVALID_ARGUMENT", "Meeting name is null", null)
//                }
//            } else {
//                result.notImplemented()
//            }
//        }
//    }
//
//    private fun startRepeatingToast(meetingName: String) {
//        runnable = object : Runnable {
//            override fun run() {
//                Toast.makeText(this@MainActivity, meetingName, Toast.LENGTH_LONG).show()
//                handler.postDelayed(this, 10000) // 10 seconds delay
//            }
//        }
//        handler.post(runnable)
//    }
//}

import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.os.Build
import androidx.core.app.NotificationCompat
import androidx.work.*
import java.util.concurrent.TimeUnit
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val channelName = "job_scheduler"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val method = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelName)

        method.setMethodCallHandler { call, result ->
            if (call.method == "meetingName") {
                val meetingName = call.argument<String>("meetingName")
                if (meetingName != null) {
                    scheduleInitialNotification(meetingName)
                    result.success(meetingName)
                } else {
                    result.error("INVALID_ARGUMENT", "Meeting name is null", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun scheduleInitialNotification(meetingName: String) {
        val workManager = WorkManager.getInstance(applicationContext)
        val inputData = workDataOf("meetingName" to meetingName)

        // Schedule the first notification with a 10-second delay
        val notificationWorkRequest = OneTimeWorkRequestBuilder<NotificationWorker>()
            .setInputData(inputData)
            .setInitialDelay(10, TimeUnit.SECONDS)
            .build()

        workManager.enqueue(notificationWorkRequest)
    }

    class NotificationWorker(context: Context, params: WorkerParameters) : Worker(context, params) {

        override fun doWork(): Result {
            val meetingName = inputData.getString("meetingName") ?: "No meeting set"

            // Show the notification
            showNotification("Meeting Reminder", meetingName)

            // Schedule the next notification
            val workManager = WorkManager.getInstance(applicationContext)
            val nextWorkRequest = OneTimeWorkRequestBuilder<NotificationWorker>()
                .setInputData(inputData)
                .setInitialDelay(10, TimeUnit.SECONDS)
                .build()

            workManager.enqueue(nextWorkRequest)

            return Result.success()
        }

        private fun showNotification(title: String, message: String) {
            val channelId = "meeting_notification_channel"
            val notificationManager =
                applicationContext.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                val channel = NotificationChannel(
                    channelId,
                    "Meeting Notifications",
                    NotificationManager.IMPORTANCE_DEFAULT
                )
                notificationManager.createNotificationChannel(channel)
            }

            val notification = NotificationCompat.Builder(applicationContext, channelId)
                .setContentTitle(title)
                .setContentText(message)
                .setSmallIcon(R.drawable.ic_launcher_foreground)
                .setAutoCancel(true)
                .build()

            notificationManager.notify(1, notification)
        }
    }
}
