<template>
  <v-card variant="outlined" class="coin-details">
    <v-list lines="one">
      <v-list-item :title="name" />
      <v-list-item title="PCGS No." :subtitle="pcgsNo" />
      <v-list-item title="Cert No." :subtitle="certNo" v-if="certNo" />
      <v-list-item :title="'Value for ' + grade" :subtitle="value ? `$${value}` : 'None Available'" />
      <v-list-item title="Denomination" :subtitle="denomination" />
      <v-list-item title="Metal Content" :subtitle="metalContent" />
      <v-list-item title="Designer" :subtitle="designer" />
      <v-list-item title="Mintage" :subtitle="mintage" />
      <v-list-item title="Diameter" :subtitle="diameter" />
      <v-list-item title="Edge" :subtitle="edge" />
      <v-list-item title="Weight" :subtitle="weight" />
      <v-list-item title="PCGS Population" :subtitle="population" />
      <v-list-item title="PCGS Details">
        <a :href="pcgsLink">{{ pcgsLink }}</a>
      </v-list-item>
      <v-list-item title="Images" v-if="imageUrl">
        <span class="image-disclaimer">
          Images attempt to show matching grade in MS, but may reflect any date/variation in the coin series
        </span>
        <img class="coin-image" :src="imageUrl.replace(/\${3}/, `${grade.match(/\d{2}/)[0]}o`)" alt="coin obverse" />
        <img class="coin-image" :src="imageUrl.replace(/\${3}/, `${grade.match(/\d{2}/)[0]}r`)" alt="coin reverse" />
      </v-list-item>
      <v-list-item title="PCGS Notes">
        <div v-html="pcgsNotes" />
      </v-list-item>
    </v-list>
  </v-card>
</template>
<script>
  export default {
    props: {
      name: { type: String, required: true },
      pcgsNo: { type: Number, required: true },
      certNo: { type: String, required: false },
      grade: { type: String, required: true },
      value: { type: Number, required: false },
      denomination: { type: String, required: true },
      metalContent: { type: String, required: true },
      designer: { type: String, required: true },
      mintage: { type: String, required: false },
      diameter: { type: Number, required: false },
      edge: { type: String, required: true },
      weight: { type: Number, required: false },
      population: { type: Number, required: false },
      pcgsLink: { type: String, required: true },
      imageUrl: { type: String, required: false },
      pcgsNotes: { type: String, required: true },
    },
  }
</script>
<style>
</style>
