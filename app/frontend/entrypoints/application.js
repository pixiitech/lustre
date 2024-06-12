import { createApp, defineAsyncComponent } from "vue";
import vuetify from "~/plugins/vuetify";
import './style.css';

import App from '~/app'
const PagesIndex = defineAsyncComponent(() => import("~/pages/index"));
const CoinDetails = defineAsyncComponent(() => import("~/components/coinDetails"));

const app = createApp({});

app.use(vuetify);

app.component("App", App);
app.component("PagesIndex", PagesIndex);
app.component("CoinDetails", CoinDetails);

app.mount("#app");
