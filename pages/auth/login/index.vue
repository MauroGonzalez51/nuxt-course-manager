<script setup lang="ts">
    import { CheckCircle, ArrowRight } from "lucide-vue-next";
    import { toTypedSchema } from "@vee-validate/zod";
    import { useForm } from "vee-validate";
    import { cn } from "@/lib/utils";
    import { z } from "zod";

    const { setLocale, t } = useI18n();

    useHead({
        title() {
            return t("pages.auth.login.title");
        },
    });

    const schema = computed(() =>
        z.object({
            email: z
                .string()
                .min(1, { message: t("pages.auth.login.form.email.zod.required") })
                .email({ message: t("pages.auth.login.form.email.zod.validation") }),
            password: z.string().min(1, {
                message: t("pages.auth.login.form.password.zod.required"),
            }),
        }),
    );

    const validationSchema = computed(() => toTypedSchema(schema.value));

    const { errors } = useForm({
        validationSchema,
        initialValues: Object.fromEntries(
            Object.keys(schema.value.shape).map((key) => [key, ""]),
        ),
    });

    const formFields = computed<FormField<z.infer<typeof schema.value>>[]>(
        () => [
            {
                name: "email",
                label: t("pages.auth.login.form.email.label"),
                type: "email",
                autocomplete: "email",
            },
            {
                name: "password",
                label: t("pages.auth.login.form.password.label"),
                type: "password",
                autocomplete: "current-password",
            },
        ],
    );

    onMounted(() => {
        const colorMode = useColorMode();

        colorMode.preference = "light";
    });
</script>

<template>
    <main class="min-h-screen grid grid-cols-1 md:grid-cols-2">
        <section
            class="hidden md:flex md:w-full bg-gray-50 flex-col justify-center p-12 relative overflow-hidden"
        >
            <div class="max-w-md z-10">
                <h1 class="text-4xl font-bold mb-6 text-gray-800 break-words">
                    {{ $t("pages.auth.login.welcome_message") }}
                </h1>
                <p class="text-gray-600 mb-8">
                    {{ $t("pages.auth.login.welcome_description") }}
                </p>
                <div class="space-y-4">
                    <div
                        v-for="item in $tm('pages.auth.login.features')"
                        :key="item"
                        class="flex items-center space-x-2"
                    >
                        <CheckCircle class="text-green-500" />
                        <span class="text-gray-700">{{ $rt(item) }}</span>
                    </div>
                </div>
            </div>
            <div class="absolute inset-0 z-0">
                <div
                    class="absolute right-0 bottom-0 w-64 h-64 bg-purple-200 rounded-full opacity-50 transform translate-x-1/2 translate-y-1/2"
                />
                <div
                    class="absolute left-0 top-0 w-96 h-96 bg-yellow-200 rounded-full opacity-50 transform -translate-x-1/2 -translate-y-1/2"
                />
            </div>
        </section>
        <aside class="w-full flex items-center justify-center p-12 bg-white">
            <div class="w-full max-w-md space-y-8">
                <div>
                    <h2 class="text-3xl font-bold text-gray-900">
                        {{ $t("pages.auth.login.title") }}
                    </h2>
                </div>
                <form class="mt-8 space-y-6">
                    <div class="rounded-md shadow-sm space-y-px">
                        <FormField
                            v-for="field in formFields"
                            v-slot="{ componentField }"
                            :key="field.name"
                            :name="field.name"
                        >
                            <FormItem>
                                <FormLabel
                                    :class="
                                        cn({
                                            'dark:text-foreground':
                                                errors[field.name],
                                        })
                                    "
                                    >{{ field.label }}</FormLabel
                                >

                                <FormControl>
                                    <Input
                                        :type="field.type"
                                        v-bind="componentField"
                                        :autocomplete="field.autocomplete"
                                        :class="
                                            cn('dark:bg-gray-700', {
                                                'border-rose-500 dark:border-orange-400 border-2':
                                                    errors[field.name],
                                            })
                                        "
                                    />
                                </FormControl>

                                <template v-if="field.description">
                                    <FormDescription>
                                        {{ field.description }}
                                    </FormDescription>
                                </template>

                                <Motion
                                    :initial="{ opacity: 0, x: 0 }"
                                    :enter="{
                                        opacity: 1,
                                        x: [0, -10, 10, -10, 10, 0],
                                        transition: {
                                            duration: 500,
                                            type: 'keyframes',
                                        },
                                    }"
                                >
                                    <FormMessage class="dark:text-orange-400" />
                                </Motion>
                            </FormItem>
                        </FormField>
                    </div>

                    <div class="flex items-center justify-between">
                        <div class="flex items-center">
                            <Input
                                id="remember-me"
                                name="remember-me"
                                type="checkbox"
                                class="h-4 w-4 text-blue-600 focus:ring-blue-500 border-gray-300 rounded"
                            />
                            <label
                                htmlFor="remember-me"
                                class="ml-2 block text-sm text-gray-900"
                            >
                                {{
                                    $t("pages.auth.login.form.button.remind_me")
                                }}
                            </label>
                        </div>

                        <div class="text-sm">
                            <a
                                href="#"
                                class="font-medium text-blue-600 hover:text-blue-500"
                            >
                                {{
                                    $t(
                                        "pages.auth.login.form.link.forgot_password",
                                    )
                                }}
                            </a>
                        </div>
                    </div>

                    <div>
                        <Button
                            class="w-full group relative flex justify-center py-2 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
                        >
                            <span
                                class="absolute left-0 inset-y-0 flex items-center pl-3"
                            >
                                <ArrowRight
                                    class="h-5 w-5 text-blue-500 group-hover:text-blue-400"
                                    aria-hidden="true"
                                />
                            </span>
                            {{ $t("pages.auth.login.form.button.submit") }}
                        </Button>
                    </div>
                </form>
                <div>
                    <Button @click="setLocale('en')"> EN </Button>
                    <Button @click="setLocale('es')">ES</Button>
                </div>
            </div>
        </aside>
    </main>
</template>
