package com.mathiewabbas.is_tv_ffi

import android.app.UiModeManager
import android.content.Context
import android.content.res.Configuration
import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Test
import org.mockito.Mockito

internal class IsTvFfiPluginTest {

  @Test
  fun isTv_whenDeviceIsTelevision_returnsTrue() {
    val mockContext = Mockito.mock(Context::class.java)
    val mockUiModeManager = Mockito.mock(UiModeManager::class.java)

    Mockito.`when`(mockContext.getSystemService(Context.UI_MODE_SERVICE)).thenReturn(mockUiModeManager)
    Mockito.`when`(mockUiModeManager.currentModeType).thenReturn(Configuration.UI_MODE_TYPE_TELEVISION)

    val plugin = IsTvFfiPlugin(mockContext)
    val result = plugin.isTv()

    assertEquals(true, result)
  }

  @Test
  fun isTv_whenDeviceIsNotTelevision_returnsFalse() {
    val mockContext = Mockito.mock(Context::class.java)
    val mockUiModeManager = Mockito.mock(UiModeManager::class.java)

    Mockito.`when`(mockContext.getSystemService(Context.UI_MODE_SERVICE)).thenReturn(mockUiModeManager)
    Mockito.`when`(mockUiModeManager.currentModeType).thenReturn(Configuration.UI_MODE_TYPE_NORMAL) // Simulate a phone

    val plugin = IsTvFfiPlugin(mockContext)
    val result = plugin.isTv()

    assertEquals(false, result)
  }
}