package com.mathiewabbas.is_tv_ffi

import android.app.UiModeManager
import android.content.Context
import android.content.pm.PackageManager
import android.content.res.Configuration
import androidx.annotation.Keep

@Keep
object IsTvFfiPlugin {
  @JvmStatic
  fun isTv(context: Context): Boolean {
    // `getSystemService` is declared nullable, and a device without a
    // UiModeManager should fall through rather than crash.
    val uiModeManager = context.getSystemService(Context.UI_MODE_SERVICE) as? UiModeManager
    if (uiModeManager?.currentModeType == Configuration.UI_MODE_TYPE_TELEVISION) {
      return true
    }

    // Some TV boxes report a non-television UI mode but still declare the
    // leanback feature, which is what a TV launcher requires.
    return context.packageManager?.hasSystemFeature(PackageManager.FEATURE_LEANBACK) == true
  }
}
