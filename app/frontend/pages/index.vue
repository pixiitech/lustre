<template>
  <v-container className="lustre-container">
    <button :class="`tab ${selectedTab === 'prices' ? 'active' : ''}`" @click="priceTab">
      Price Guide
    </button>
    <button :class="`tab ${selectedTab === 'lookup' ? 'active' : ''}`" @click="lookupTab">
      Holder Lookup
    </button>
    <v-card class="tab" v-if="selectedTab === 'lookup'" variant="tonal">
      <input type="text" name="cert_number" placeholder="Enter 8-digit PCGS #" v-model="certificateNumber" />
      <button @click="fetchCertData()" :disabled="!certificateNumber">
        Submit
      </button>
      <v-card variant="outlined" v-if="loading" class="spinner">
        Fetching Data...
      </v-card>
      <CoinDetails v-if="certificateDetails"
        :name="certificateDetails.Name" :pcgsNo="certificateDetails.PCGSNo"
        :certNo="certificateDetails.CertNo" :value="certificateDetails.PriceGuideValue"
        :grade="certificateDetails.Grade" :denomination="certificateDetails.Denomination"
        :metalContent="certificateDetails.MetalContent" :designer="certificateDetails.Designer"
        :mintage="certificateDetails.Mintage" :diameter="certificateDetails.Diameter"
        :edge="certificateDetails.Edge" :weight="certificateDetails.Weight"
        :population="certificateDetails.Population" :pcgsLink="certificateDetails.CoinFactsLink"
        :imageUrlTemplate="certificateDetails.image_url_template" :pcgsNotes="certificateDetails.CoinFactsNotes"
      />
    </v-card>
    <v-card class="tab" v-if="selectedTab === 'prices'" variant="tonal">
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
      <div v-if="selectedSeries" v-for="mintType in filteredMintTypes()">
        <button
          v-if="!selectedMintType || selectedMintType[0] === mintType[0]"
          :class="`category ${selectedMintType && selectedMintType[0]=== mintType[0] ? 'active' : ''}`"
          @click="selectedMintType ? clearMintType() : selectMintType(mintType)"
        >
          {{ mintType[1] }}
          <span v-if="selectedMintType">X</span>
        </button>
      </div>
      <button class="category active" v-if="selectedCoin" @click="clearCoin()">
        {{ selectedCoin.description }}
        <span>X</span>
      </button>
      <v-row v-if="selectedMintType && !selectedCoin" class="coin-varieties" no-gutters>
        <v-col lg="4" md="6" cols="12" v-for="coin in coinVarieties">
          <button class="category" @click="selectedCoin = coin">
            {{ coin.description }}
          </button>
        </v-col>
      </v-row>
      <v-row v-if="selectedCoin" class="coin-grades" no-gutters>
        <button
          class="category active"
          v-if="selectedGrade"
          @click="clearGrade()"
        >
          {{ selectedGrade[1] }}
          <span>X</span>
        </button>
        <v-col :cols="selectedGrade ? 12 : 3"
          v-for="grade in (selectedCoin.mint_type == 'MS' ? availableGrades : availableProofGrades)"
          v-if="!selectedGrade"
        >
          <button
            class="category coin-grade"
            @click="selectGrade(grade)"
          >
            {{ grade[1] }}
            <span v-if="selectedGrade">X</span>
          </button>
        </v-col>
      </v-row>
      <v-card v-if="loading" class="spinner">
        Fetching Data...
      </v-card>
      <CoinDetails v-if="coinDetails"
        :name="coinDetails.coin_variety.description" :pcgsNo="coinDetails.coin_variety.pcgs_id"
        :value="coinDetails.value" :grade="selectedGrade[1]"
        :denomination="coinDetails.coin_variety.denomination"
        :metalContent="coinDetails.coin_variety.metal_content"
        :designer="coinDetails.coin_variety.designer" :mintage="coinDetails.coin_variety.mintage"
        :diameter="coinDetails.coin_variety.diameter" :edge="coinDetails.coin_variety.edge"
        :weight="coinDetails.coin_variety.weight" :population="coinDetails.coin_variety.population"
        :pcgsLink="coinDetails.coin_variety.pcgs_link" :imageUrlTemplate="selectedSeries.photo_url"
        :pcgsNotes="coinDetails.coin_variety.pcgs_notes"
      />
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
        selectedMintType: null,
        coinVarieties: [],
        loading: false,
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
        mintTypes: [['MS', 'Mint State (MS)'], ['PR', 'Proof (PR)'], ['SP', 'Specimen (SP)']],
        coinDetails: null,
        certificateDetails: null,
        certificateNumber: null,
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
      },
      selectMintType(mintType) {
        this.selectedMintType = mintType;
        this.fetchCoins(this.selectedSeries.id, mintType[0]);
      },
      clearSeries() {
        this.selectedSeries = null;
        this.selectedMintType = null;
        this.clearCoin();
      },
      fetchCoins(id, mintType) {
        this.loading = true;
        axios.get(`/coin_varieties/?series_id=${id}&mint_type=${mintType}`).then(
          (response) => {
            this.loading = false;
            this.coinVarieties = response.data;
          }
        );
      },
      clearCoin() {
        this.selectedCoin = null;
        this.coinVarieties = null;
        this.clearGrade();
        if (this.selectedSeries && this.selectedMintType) {
          this.fetchCoins(this.selectedSeries.id, this.selectedMintType[0]);
        }
      },
      filteredMintTypes() {
        return this.mintTypes.filter(
          mintType => (this.selectedSeries.mint_types.includes(mintType[0])));
      },
      clearMintType() {
        this.selectedMintType = null;
        this.clearCoin();
      },
      selectGrade(grade) {
        this.selectedGrade = grade;
        this.loading = true;
        axios.get(`/coin_varieties/${this.selectedCoin.id}?grade=${grade[0]}`).then(
          (response) => {
            this.loading = false;
            this.coinDetails = response.data;
          }
        );
      },
      clearGrade() {
        this.selectedGrade = null;
        this.coinDetails = null;
      },
      fetchCertData() {
        this.loading = true;
        axios.get(`/pcgs_lookup?cert_no=${this.certificateNumber}`).then(
          (response) => {
            this.loading = false;
            this.certificateDetails = response.data;
          }
        );
      },
    }
  }

</script>
<style>
</style>
