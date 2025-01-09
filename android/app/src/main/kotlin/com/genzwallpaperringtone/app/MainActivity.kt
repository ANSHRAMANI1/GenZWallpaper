package com.genzwallpaperringtone.app

import android.app.DownloadManager
import android.app.WallpaperManager
import android.content.BroadcastReceiver
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.net.Uri
import android.os.Environment
import android.util.Log
import com.genzwallpaperringtone.app.downloader.WallpaperDownloader
import com.genzwallpaperringtone.app.service.VideoLiveWallpaperService
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin
import java.io.File


class MainActivity: FlutterActivity() {

    private val EVENTS = "com.demo.methodchannel"
    var methodChannelResult: MethodChannel.Result? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        flutterEngine.plugins.add(GoogleMobileAdsPlugin())
        super.configureFlutterEngine(flutterEngine)
        GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine,
                "adFactoryExample", NativeAdFactoryExample(layoutInflater))

        registerReceiver(onComplete, IntentFilter(DownloadManager.ACTION_DOWNLOAD_COMPLETE))

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            EVENTS
        ).setMethodCallHandler { call, result ->
            methodChannelResult = result;

            if (call.method == "downloadWallpaper") {
                val imageUrl = call.argument<String>("imageUrl")
//                val fileName = call.argument<String>("fileName")
                val downloader = WallpaperDownloader(this)
                Log.d("DOWNLOAD PATH",Environment.getExternalStorageDirectory().path)
                val file = File(this.getExternalFilesDir(Environment.DIRECTORY_PICTURES) , "wallpaper.mp4")
//                val file = File("/storage/emulated/0/Pictures/wallpaper.mp4")
                if (file.exists()) file.delete()
                if (imageUrl != null) {
                    Log.d("DOWNLOAD PATH",context.getApplicationContext().getFilesDir().path)
                    val data = downloader.downloadUrl(imageUrl,"")
                }
            }

            if(call.method == "liveWallpaper"){
                val videoUrl = call.argument<String>("videoUrl")
                val intent = Intent(WallpaperManager.ACTION_CHANGE_LIVE_WALLPAPER)
                intent.putExtra(
                    WallpaperManager.EXTRA_LIVE_WALLPAPER_COMPONENT,
                    ComponentName(this, VideoLiveWallpaperService::class.java)
                )
                startActivity(intent)
            }

            if(call.method == "refreshMedia"){
                val filePath = call.argument<String>("filePath")
                if (filePath != null) {
                    broadcastFileUpdate(filePath)
                }
            }
        }

    }

    private fun broadcastFileUpdate(path: String) {
        context.sendBroadcast(Intent(Intent.ACTION_MEDIA_SCANNER_SCAN_FILE, Uri.fromFile(File(path))))
        println("updated!")
    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        super.cleanUpFlutterEngine(flutterEngine)
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "adFactoryExample")
    }

    var onComplete: BroadcastReceiver = object : BroadcastReceiver() {
        override fun onReceive(ctxt: Context, intent: Intent) {
            val intent = Intent(WallpaperManager.ACTION_CHANGE_LIVE_WALLPAPER)
            intent.putExtra(WallpaperManager.EXTRA_LIVE_WALLPAPER_COMPONENT,
                ComponentName(this@MainActivity, VideoLiveWallpaperService::class.java)
            )
            startActivity(intent)
        }
    }
}
