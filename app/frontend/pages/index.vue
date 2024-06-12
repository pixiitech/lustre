<template>
  <v-container className="lustre-container">
    <button :class="`tab ${selectedTab === 'prices' ? 'active' : ''}`" @click="priceTab">
      Price Guide
    </button>
    <button :class="`tab ${selectedTab === 'lookup' ? 'active' : ''}`" @click="lookupTab">
      Holder Lookup
    </button>
    <v-card v-if="selectedTab === 'lookup'" variant="tonal">
      <h3>Certificate Lookup#</h3>
      <input type="text" name="cert_number" placeholder="Enter 8-digit PCGS #" v-model="certificateNumber" />
      <button @click="fetchCertData()" v-disabled="!certificateNumber">
        Submit
      </button>
      <v-card variant="outlined" v-if="certificateDetails" class="coin-details">
        <v-list lines="one">
          <v-list-item :title="certificateDetails.name" />
          <v-list-item title="PCGS No." :subtitle="certificateDetails.PCGSNo" />
          <v-list-item title="Cert No." :subtitle="certificateDetails.CertNo" />
          <v-list-item :title="'Value for ' + certificateDetails.Grade" :subtitle="`$${certificateDetails.PriceGuideValue}` || 'None Available'" />
          <v-list-item title="Denomination" :subtitle="certificateDetails.Denomination" />
          <v-list-item title="Metal Content" :subtitle="certificateDetails.MetalContent" />
          <v-list-item title="Designer" :subtitle="certificateDetails.Designer" />
          <v-list-item title="Mintage" :subtitle="certificateDetails.Mintage" />
          <v-list-item title="Diameter" :subtitle="certificateDetails.Diameter" />
          <v-list-item title="Edge" :subtitle="certificateDetails.Edge" />
          <v-list-item title="Weight" :subtitle="certificateDetails.Weight" />
          <v-list-item title="PCGS Population" :subtitle="certificateDetails.Population" />
          <v-list-item title="PCGS Details">
            <a :href="certificateDetails.CoinFactsLink">{{ certificateDetails.pcgs_link }}</a>
          </v-list-item>
          <v-list-item title="Images" v-if="certificateDetails.Images.length">
            <img v-for="url in certificateDetails.Images" :src="url" alt="coin image" />
          </v-list-item>
          <v-list-item title="PCGS Notes" :v-html="certificateDetails.CoinFactsNotes" />
        </v-list>
      </v-card>
    </v-card>
    <v-card v-if="selectedTab === 'prices'" variant="tonal">
      <h3>Select Coin Details</h3>
      <div v-for="cat in categories">
        <button
          v-if="!selectedCategory || selectedCategory.name === cat.name"
          :class="`category ${selectedCategory && selectedCategory.name === cat.name ? 'active' : ''}`"
          @click="selectedCategory ? clearCategory() : selectedCategory = cat"
        >
          {{ cat.name }}
          <span v-if="selectedCategory">X</span>
        </button>
      </div>
      <div v-if="selectedCategory" v-for="series in selectedCategory.series">
        <button
          v-if="!selectedSeries || selectedSeries.name === series.name"
          :class="`category ${selectedSeries && selectedSeries.name === series.name ? 'active' : ''}`"
          @click="selectedSeries ? clearSeries() : selectSeries(series)"
        >
          {{ series.name }}
          <span v-if="selectedSeries">X</span>
        </button>
      </div>
      <div v-if="selectedSeries" @load="fetchCoins()">
        <div v-for="coin in coinVarieties">
          <button
            v-if="!selectedCoin || selectedCoin.id === coin.id"
            :class="`category ${selectedCoin && selectedCoin.id === coin.id ? 'active' : ''}`"
            @click="selectedCoin ? clearCoin() : selectedCoin = coin"
          >
            {{ coin.description }}
            <span v-if="selectedCoin">X</span>
          </button>
        </div>
      </div>
      <v-row v-if="selectedCoin" class="coin-grades">
        <v-col :cols="selectedGrade ? 12 : 3"
          v-for="grade in (selectedCoin.mint_type == 'PR' ? availableProofGrades : availableGrades)"
          v-if="!selectedGrade || (grade && selectedGrade[0] === grade[0])"
        >
          <button
            :class="`category coin-grade ${selectedGrade && selectedGrade[0] === grade[0] ? 'active' : ''}`"
            @click="selectedGrade ? clearGrade() : selectGrade(grade)"
          >
            {{ grade[1] }}
            <span v-if="selectedGrade">X</span>
          </button>
        </v-col>
      </v-row>
      <v-card variant="outlined" v-if="coinDetails" class="coin-details">
        <v-list lines="one">
          <v-list-item :title="coinDetails.coin_variety.description" />
          <v-list-item :title="'Value for ' + selectedGrade[1]" :subtitle="`$${coinDetails.value}` || 'None Available'" />
          <v-list-item title="Denomination" :subtitle="coinDetails.coin_variety.denomination" />
          <v-list-item title="Metal Content" :subtitle="coinDetails.coin_variety.metal_content" />
          <v-list-item title="Designer" :subtitle="coinDetails.coin_variety.designer" />
          <v-list-item title="Mintage" :subtitle="coinDetails.coin_variety.mintage" />
          <v-list-item title="Diameter" :subtitle="coinDetails.coin_variety.diameter" />
          <v-list-item title="Edge" :subtitle="coinDetails.coin_variety.edge" />
          <v-list-item title="Weight" :subtitle="coinDetails.coin_variety.weight" />
          <v-list-item title="PCGS Population" :subtitle="coinDetails.coin_variety.population" />
          <v-list-item title="PCGS Details">
            <a :href="coinDetails.coin_variety.pcgs_link">{{ coinDetails.coin_variety.pcgs_link }}</a>
          </v-list-item>
          <v-list-item title="Images" v-if="coinDetails.coin_variety.images.length">
            <img v-for="url in coinDetails.coin_variety.images" :src="url" alt="coin image" />
          </v-list-item>
          <v-list-item title="PCGS Notes" :v-html="coinDetails.coin_variety.pcgs_notes" />
        </v-list>
      </v-card>
    </v-card>
  </v-container>
</template>
<script>
  import axios from "axios";

  export default {
    props: {
      categories: { type: Array, required: true },
    },
    data(props) {
      return {
        selectedTab: "prices",
        selectedCategory: null,
        selectedSeries: null,
        selectedCoin: null,
        selectedGrade: null,
        coinVarieties: [],
        availableGrades: [
          [1, "PO-1"], [2, "FR-2"], [3, "AG-3"], [4, "G-4"], [6, "G-6"], [8, "VG-8"],
          [10, "VG-10"], [12, "F-12"], [15, "F-15"], [20, "VF-20"], [25, "VF-25"],
          [30, "VF-30"], [35, "VF-35"], [40, "XF-40"], [45, "XF-45"], [50, "AU-50"],
          [53, "AU-53"], [55, "AU-55"], [58, "AU-58"], [60, "MS-60"], [61, "MS-61"],
          [62, "MS-62"], [63, "MS-63"], [64, "MS-64"], [65, "MS-65"], [66, "MS-66"],
          [67, "MS-67"], [68, "MS-68"], [69, "MS-69"], [70, "MS-70"],
        ],
        availableProofGrades: [
          [60, "PR-60"], [61, "PR-61"], [62, "PR-62"], [63, "PR-63"], [64, "PR-64"],
          [65, "PR-65"], [66, "PR-66"], [67, "PR-67"], [68, "PR-68"], [69, "PR-69"],
          [70, "PR-70"],
        ],
        coinDetails: null,
        certificateDetails: null,
      }
    },
    methods: {
      lookupTab() {
        this.selectedTab = "lookup";
      },
      priceTab() {
        this.selectedTab = "prices";
      },
      clearCategory() {
        this.clearSeries();
        this.selectedCategory = null;
      },
      selectSeries(series) {
        this.selectedSeries = series;
        this.fetchCoins(series.id);
      },
      clearSeries() {
        this.clearCoin();
        this.selectedSeries = null;
      },
      fetchCoins(id) {
        axios.get(`/coin_varieties/?series_id=${id}`).then(
          (response) => {
            this.coinVarieties = response.data;
          }
        );
      },
      clearCoin() {
        this.selectedCoin = null;
        this.coinVarieties = null;
        this.clearGrade();
      },
      selectGrade(grade) {
        this.selectedGrade = grade;
        axios.get(`/coin_varieties/${this.selectedCoin.id}?grade=${grade[0]}`).then(
          (response) => {
            this.coinDetails = response.data;
          }
        );
      },
      clearGrade() {
        this.selectedGrade = null;
        this.coinDetails = null;
      },
      fetchCertData() {
        axios.get(`/pcgs_lookup?cert_no=${this.certificateNumber}`).then(
          (response) => {
            this.certificateDetails = response.data;
          }
        );
      },
    }
  }

</script>
<style>
  h1 {
    color: blue;
  }
</style>
