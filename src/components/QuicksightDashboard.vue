<template>
  <div>
    Dashobard

    <button @click="showDashboad">Show dashboard</button>

    <div>
      <div id="embeddingContainer" class="embeddedReport"></div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import { embedSession } from "amazon-quicksight-embedding-sdk";

export default {
  methods: {
    showDashboad() {
      var apiUrl = "https://aw0q3ni97c.execute-api.us-west-2.amazonaws.com/dev";
      axios.get(apiUrl).then((res) => {
        var embedData = this.fixJSON(res.data);

        var options = {
          url: embedData.EmbedUrl,
          container: document.getElementById("embeddingContainer"),
          parameters: {},
          scrolling: "no",
          height: "2768px%",
          width: "100%",
          locale: "en-US",
          footerPaddingEnabled: true,
          defaultEmbeddingVisualType: "TABLE", // this option only applies to experience embedding and will not be used for dashboard embedding
        };

        document.getElementById("embeddingContainer").innerHTML = ""; // clear the div before placing new report in it
        embedSession(options); // Finally embed the report
      });
    },
    fixJSON: function (unQuotedJSON) {
      // Change relaxedJson to strict json
      var fixedJSON = unQuotedJSON
        // Replace ":" with "@colon@" if it's between double-quotes
        .replace(/:\s*"([^"]*)"/g, function (match, p1) {
          return ': "' + p1.replace(/:/g, "@colon@") + '"';
        })
        // Replace ":" with "@colon@" if it's between single-quotes
        .replace(/:\s*'([^']*)'/g, function (match, p1) {
          return ': "' + p1.replace(/:/g, "@colon@") + '"';
        })
        // Add double-quotes around any tokens before the remaining ":"
        .replace(/(['"])?([a-z0-9A-Z_]+)(['"])?\s*:/g, '"$2": ')
        // Turn "@colon@" back into ":"
        .replace(/@colon@/g, ":");
      return JSON.parse(fixedJSON);
    },
  },
};
</script>

<style scoped>
</style>