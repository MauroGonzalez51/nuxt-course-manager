import type { InputHTMLAttributes } from "vue";

declare global {
    interface FormField<T extends object> {
        name: keyof T;
        label: string;
        type: InputHTMLAttributes["type"];
        description?: string;

        // https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/autocomplete for more info about this field
        autocomplete: InputHTMLAttributes["autocomplete"];
    }
}

export {};
