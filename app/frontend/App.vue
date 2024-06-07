<template>
  <v-app id="vuetify-app">
    <v-main>
      <p>Vuetify 3 App Running 🍾🎉</p>
      <p>Message= {{ message }}</p>
      <slot></slot>
    </v-main>
  </v-app>
</template>

<script>
  export default {
    props: {
      message: { type: String, required: true },
    },
  };
</script>
