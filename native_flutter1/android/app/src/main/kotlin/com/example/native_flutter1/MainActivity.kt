package com.example.native_flutter1

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.os.Build
import android.os.Handler
import android.os.Looper
import android.app.Service
import android.os.IBinder
import androidx.core.app.NotificationCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.native_flutter1"
    private lateinit var notificationChannelId: String

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "startJobScheduler") {
                startService(Intent(this, NotificationService::class.java))
                result.success("Job scheduler started")
            } else {
                result.notImplemented()
            }
        }
    }

    // NotificationService as an inner class
    inner class NotificationService : Service() {

        private val handler = Handler(Looper.getMainLooper())
        private val notificationId = 1

        override fun onCreate() {
            super.onCreate()
            notificationChannelId = createNotificationChannel()
            startForeground(notificationId, createNotification())
            scheduleNotification()
        }

        private fun createNotificationChannel(): String {
            val channelId = "notification_channel"
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                val channelName = "Job Scheduler Notifications"
                val channel = NotificationChannel(channelId, channelName, NotificationManager.IMPORTANCE_LOW)
                val notificationManager = getSystemService(NotificationManager::class.java)
                notificationManager.createNotificationChannel(channel)
            }
            return channelId
        }

        private fun createNotification(): Notification {
            val intent = Intent(this, MainActivity::class.java).apply {
                flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK
            }
            val pendingIntent = PendingIntent.getActivity(
                this,
                0,
                intent,
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
            )
            return NotificationCompat.Builder(this, notificationChannelId)
                .setContentTitle("Job Meeting Reminder")
                .setContentText("Reminder every 10 seconds")
                .setSmallIcon(R.drawable.ic_launcher_foreground)
                .setContentIntent(pendingIntent)
                .build()
        }

        private fun scheduleNotification() {
            handler.post(object : Runnable {
                override fun run() {
                    val notificationManager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
                    notificationManager.notify(notificationId, createNotification())
                    handler.postDelayed(this, 10000) // 10 seconds
                }
            })
        }

        override fun onBind(intent: Intent?): IBinder? {
            return null
        }
    }
}
