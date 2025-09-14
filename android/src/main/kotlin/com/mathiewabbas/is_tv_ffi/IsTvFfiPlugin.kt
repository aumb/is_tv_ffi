package com.mathiewabbas.is_tv_ffi

import android.app.UiModeManager
import android.content.Context
import android.content.res.Configuration
import androidx.annotation.Keep


@Keep
object IsTvFfiPlugin {
  @JvmStatic
  fun isTv(context: Context): Boolean {
    val uiModeManager =
      context.getSystemService(Context.UI_MODE_SERVICE) as UiModeManager
    return uiModeManager.currentModeType == Configuration.UI_MODE_TYPE_TELEVISION
  }
}