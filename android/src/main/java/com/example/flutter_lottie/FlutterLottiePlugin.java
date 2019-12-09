package com.example.flutter_lottie;

import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * FlutterLottiePlugin
 */
public class FlutterLottiePlugin {
    /**
     * Plugin registration.
     */
    public static void registerWith(Registrar registrar) {
        registrar.platformViewRegistry().registerViewFactory(
                "convictiontech/flutter_lottie",
                new LottieViewFactory(registrar)
        );
    }
}
