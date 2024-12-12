// https://nuxt.com/docs/api/configuration/nuxt-config
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
    ],
});
