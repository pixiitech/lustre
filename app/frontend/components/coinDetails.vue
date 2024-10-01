<template>
  <v-card variant="outlined" class="coin-details">
    <h3>{{ name }}</h3>
    <v-row no-gutters>
      <v-col lg="3" md="6" cols="12">
        <div class="heading">PCGS No.</div>
        {{ pcgsNo }}
      </v-col>
      <v-col lg="3" md="6" cols="12" v-if="certNo">
        <div class="heading">Cert No.</div>
        {{ certNo }}
      </v-col>
      <v-col lg="3" md="6" cols="12">
        <div class="heading">
          {{ 'Value for ' + grade }}
        </div>
        <span v-if="value && value > 0">
          ${{ value }}
        </span>
        <span v-if="!value">
          --
        </span>
      </v-col>
      <v-col lg="3" md="6" cols="12">
        <div class="heading">Denomination</div>
        {{ denomination }}
      </v-col>
      <v-col lg="3" md="6" cols="12">
        <div class="heading">Metal Content</div>
        {{ metalContent }}
      </v-col>
      <v-col lg="3" md="6" cols="12">
        <div class="heading">Designer</div>
        {{ designer }}
      </v-col>
      <v-col lg="3" md="6" cols="12">
        <div class="heading">Mintage</div>
        {{ mintage }}
      </v-col>
      <v-col lg="3" md="6" cols="12">
        <div class="heading">Diameter</div>
        {{ diameter }}
      </v-col>
      <v-col lg="3" md="6" cols="12">
        <div class="heading">Edge</div>
        {{ edge }}
      </v-col>
      <v-col lg="3" md="6" cols="12">
        <div class="heading">Weight</div>
        {{ weight }} grams
      </v-col>
      <v-col lg="3" md="6" cols="12">
        <div class="heading">Population in PCGS</div>
        {{ population }}
      </v-col>
      <v-col cols="12" v-if="pcgsLink">
        <div class="heading">Link</div>
        <a :href="pcgsLink">{{ pcgsLink }}</a>
      </v-col>
      <v-col cols="12" v-if="imageUrlTemplate">
        <div class="image-disclaimer">
          Images attempt to show matching grade in MS, but may reflect any date/variation in the coin series
        </div>
        <img class="coin-image" :src="imageUrl('o')" alt="coin obverse" />
        <img class="coin-image" :src="imageUrl('r')" alt="coin reverse" />
      </v-col>
      <v-col cols="12" v-if="pcgsNotes">
        <div class="heading">Notes</div>
        <div v-html="pcgsNotes" />
      </v-col>
    </v-row>
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
      imageUrlTemplate: { type: String, required: false },
      pcgsNotes: { type: String, required: false },
    },
    data(props) {
      return {
        numericGrade: props.grade.match(/\d{2}|\d{1}/)[0],
      };
    },
    methods: {
      imageUrl(side) {
        let paddedGrade = this.numericGrade.length === 1 ? `0${this.numericGrade}` : this.numericGrade;
        return this.imageUrlTemplate.replace(/\${3}/, `${paddedGrade}${side}`);
      },
    },
  }
</script>
<style>
</style>
