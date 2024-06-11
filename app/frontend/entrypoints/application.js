import { createApp, defineAsyncComponent } from "vue";
import vuetify from "~/plugins/vuetify";
import './style.css';

import App from '~/app'
const BlogsIndex = defineAsyncComponent(() => import("~/pages/blogs/index"));
const BlogsShow = defineAsyncComponent(() => import("~/pages/blogs/show"));
const PagesIndex = defineAsyncComponent(() => import("~/pages/index"));

const app = createApp({});

app.use(vuetify);

app.component("App", App);
app.component("PagesIndex", PagesIndex);
app.component("BlogsIndex", BlogsIndex);
app.component("BlogsShow", BlogsShow);

app.mount("#app");
