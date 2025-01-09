package com.genzwallpaperringtone.app.service

import android.media.MediaPlayer
import android.os.Environment
import android.service.wallpaper.WallpaperService
import android.util.Log
import android.view.SurfaceHolder
import java.io.File
import java.io.FileInputStream

class VideoLiveWallpaperService  : WallpaperService() {

    override fun onCreateEngine(): WallpaperService.Engine {
        return VideoEngine()
    }

    internal inner class VideoEngine : WallpaperService.Engine() {

        private val TAG = javaClass.simpleName
        private val mediaPlayer: MediaPlayer

        init {
            Log.i(TAG, "( VideoEngine )")
            mediaPlayer = MediaPlayer()
            mediaPlayer.isLooping = true
            mediaPlayer.setDataSource(FileInputStream(File(this@VideoLiveWallpaperService.getExternalFilesDir(Environment.DIRECTORY_PICTURES) , "wallpaper.mp4")).fd)
//            mediaPlayer.setDataSource(FileInputStream(File(Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES),"wallpaper.mp4")).fd)
//            mediaPlayer.setDataSource(applicationContext, Uri.fromFile(File(Environment.DIRECTORY_DOWNLOADS,"/Wallpaper App/1708687257124-wallpaper.1_ruwruk.mp4")))
            mediaPlayer.setOnPreparedListener {
                mediaPlayer.start()
                val log1 = (0).toFloat()
                mediaPlayer.setVolume(log1,log1)
            }
            mediaPlayer.prepareAsync()
        }

        override fun onSurfaceCreated(holder: SurfaceHolder) {
            Log.i(TAG, "onSurfaceCreated")
            mediaPlayer.setSurface(holder.surface)
            mediaPlayer.start()
        }

        override fun onSurfaceDestroyed(holder: SurfaceHolder) {
            Log.i(TAG, "( INativeWallpaperEngine ): onSurfaceDestroyed")
            playheadTime = mediaPlayer.currentPosition
            mediaPlayer.reset()
            mediaPlayer.release()
        }
    }

    companion object {
        protected var playheadTime = 0
    }

}