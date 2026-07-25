package com.mathiewabbas.is_tv_ffi

import android.app.UiModeManager
import android.content.Context
import android.content.pm.PackageManager
import android.content.res.Configuration
import org.junit.jupiter.api.Assertions.assertFalse
import org.junit.jupiter.api.Assertions.assertTrue
import org.junit.jupiter.api.Test
import org.mockito.Mockito

internal class IsTvFfiPluginTest {

  /**
   * Builds a [Context] that reports [uiModeType] (or no UiModeManager at all
   * when it is null) and whether the leanback feature is available.
   */
  private fun mockContext(uiModeType: Int?, hasLeanback: Boolean = false): Context {
    val context = Mockito.mock(Context::class.java)

    val uiModeManager = uiModeType?.let {
      Mockito.mock(UiModeManager::class.java).apply {
        Mockito.`when`(currentModeType).thenReturn(it)
      }
    }
    Mockito.`when`(context.getSystemService(Context.UI_MODE_SERVICE)).thenReturn(uiModeManager)

    val packageManager = Mockito.mock(PackageManager::class.java)
    Mockito.`when`(packageManager.hasSystemFeature(PackageManager.FEATURE_LEANBACK))
      .thenReturn(hasLeanback)
    Mockito.`when`(context.packageManager).thenReturn(packageManager)

    return context
  }

  @Test
  fun isTv_whenDeviceIsTelevision_returnsTrue() {
    val context = mockContext(Configuration.UI_MODE_TYPE_TELEVISION)

    assertTrue(IsTvFfiPlugin.isTv(context))
  }

  @Test
  fun isTv_whenDeviceIsNotTelevision_returnsFalse() {
    val context = mockContext(Configuration.UI_MODE_TYPE_NORMAL) // Simulate a phone

    assertFalse(IsTvFfiPlugin.isTv(context))
  }

  @Test
  fun isTv_whenUiModeIsNotTelevisionButLeanbackIsAvailable_returnsTrue() {
    val context = mockContext(Configuration.UI_MODE_TYPE_NORMAL, hasLeanback = true)

    assertTrue(IsTvFfiPlugin.isTv(context))
  }

  @Test
  fun isTv_whenUiModeManagerIsUnavailable_fallsBackToLeanback() {
    assertTrue(IsTvFfiPlugin.isTv(mockContext(uiModeType = null, hasLeanback = true)))
    assertFalse(IsTvFfiPlugin.isTv(mockContext(uiModeType = null, hasLeanback = false)))
  }
}
