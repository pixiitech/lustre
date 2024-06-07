import { createApp, defineAsyncComponent } from "vue";
import vuetify from "~/plugins/vuetify";
import './style.css';

import App from '../App'
const PagesIndex = defineAsyncComponent(() => import("~/pages/index"));

const app = createApp(App);

app.use(vuetify);

app.component("App", App);
app.component("PagesIndex", PagesIndex);

app.mount("#app");
