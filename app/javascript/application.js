// Entry point for the build script in your package.json
import "@fortawesome/fontawesome-free/js/all";
import "@hotwired/turbo-rails";
import Chart from "chart.js/auto";
import ChartDataLabels from "chartjs-plugin-datalabels";
import "chartkick/chart.js";
import "./controllers";

Chart.register(ChartDataLabels);

Chart.defaults.set("plugins.datalabels", {
  color: "transparent",
});
