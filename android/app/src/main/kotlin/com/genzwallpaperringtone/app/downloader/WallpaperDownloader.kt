package com.genzwallpaperringtone.app.downloader

import android.app.DownloadManager
import android.content.Context
import android.net.Uri
import android.os.Environment

class WallpaperDownloader(
    private val context: Context,
): Downloader {

    private val downloadManager = context.getSystemService(DownloadManager::class.java)

    override fun downloadUrl(url: String,fileName: String): Long {
        val request = DownloadManager.Request(Uri.parse(url))
            .setMimeType("video/mp4")
            .setTitle("wallpaper.mp4")
            .setDestinationInExternalFilesDir(context,Environment.DIRECTORY_PICTURES,"wallpaper.mp4")
//            .setDestinationInExternalPublicDir(Environment.DIRECTORY_PICTURES,"wallpaper.mp4")

        return downloadManager.enqueue(request)
    }
}