<template>
  <v-container className="lustre-container">
    <button :class="`tab ${selectedTab === 'prices' ? 'active' : ''}`" @click="priceGuide">
      Price Guide
    </button>
    <button :class="`tab ${selectedTab === 'lookup' ? 'active' : ''}`" @click="lookupCert">
      Holder Lookup
    </button>
    <v-card v-if="selectedTab === 'lookup'" variant="tonal">
      <h3>Certificate Lookup#</h3>
      <input type="text" name="cert_number" placeholder="Enter PCGS #" />
    </v-card>
    <v-card v-if="selectedTab === 'prices'" variant="tonal">
      <h3>Select Coin Details</h3>
      <div v-for="cat in categories">
        <button
          v-if="!selectedCategory || selectedCategory.label === cat.label"
          :class="`category ${selectedCategory && selectedCategory.label === cat.label ? 'active' : ''}`"
          @click="selectedCategory ? clearCategory() : selectedCategory = cat"
        >
          {{ cat.label }}
          <span v-if="selectedCategory">X</span>
        </button>
      </div>
      <div v-if="selectedCategory" v-for="series in selectedCategory.series">
        <button
          v-if="!selectedSeries || selectedSeries === series.label"
          :class="`category ${selectedSeries === series.label ? 'active' : ''}`"
          @click="selectedSeries ? selectedSeries = null : selectedSeries = series.label"
        >
          {{ series.label }}
          <span v-if="selectedSeries">X</span>
        </button>
      </div>
    </v-card>
  </v-container>
</template>
<script>
  export default {
    props: {
      categories: { type: Array, required: true },
    },
    data(props) {
      return {
        selectedTab: "prices",
        selectedCategory: null,
        selectedSeries: null,
      }
    },
    methods: {
      lookupCert() {
        this.selectedTab = "lookup";
      },
      priceGuide() {
        this.selectedTab = "prices";
      },
      clearCategory() {
        this.selectedCategory = null;
        this.selectedSeries = null;
      }
    }
  }

</script>
<style>
  h1 {
    color: blue;
  }
</style>
