export default defineNuxtConfig({
    compatibilityDate: "2024-11-01",
    devtools: { enabled: true },
    modules: [
        "@nuxt/eslint",
        "@nuxtjs/tailwindcss",
        ["@nuxtjs/color-mode", { classSuffix: "" }],
        "shadcn-nuxt",
        "@nuxt/icon",
        [
            "@nuxtjs/supabase",
            {
                redirectOptions: {
                    login: "/auth/login",
                },
            },
        ],
        "@vueuse/motion/nuxt",
        [
            "@nuxtjs/i18n",
            {
                locales: [
                    { code: "en", language: "en-US", file: "en.json" },
                    { code: "es", language: "es-ES", file: "es.json" },
                ],
                defaultLocale: "en",
                strategy: "no_prefix",
                lazy: true,
            },
        ],
    ],
});
