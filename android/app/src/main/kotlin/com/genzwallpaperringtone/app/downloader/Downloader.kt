package com.genzwallpaperringtone.app.downloader

interface Downloader {
    fun downloadUrl(url: String,fileName: String): Long
}