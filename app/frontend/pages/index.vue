<template>
  <v-app id="vuetify-app">
    <button @click="lookupCert">Holder Lookup</button>
    <button @click="priceGuide">Price Guide</button>
    <v-card variant="tonal">
      <h3>Certificate Lookup#</h3>
      <input type="text" name="cert_number" placeholder="Enter PCGS #" />
    </v-card>
    <v-card variant="tonal">
      <h3>Select Coin Details</h3>
      <h1>{{ message }}</h1>
      <button @click="reverseMessage">Reverse Message</button>
    </v-card>
  </v-app>
</template>
<script>
  export default {
    props: {
      message: { type: String, required: true },
    },
    data() {
      return {
        message: window.getElementById("app").dataset['message']
      }
    },
    methods: {
      reverseMessage() {
        this.message = this.message.split('').reverse().join('')
      }
    }
  }

</script>
<style>
  h1 {
    color: blue;
  }
</style>
