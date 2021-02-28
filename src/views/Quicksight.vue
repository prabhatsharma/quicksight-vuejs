<template>
  <div class="about">
    <h1>This is the embedded quicksight demo page</h1>
    <QuicksightDashboard dashboardId="11f05d8a-4a94-46c6-ad50-e6cb819934c5" />
  </div>
</template>

<script>
import QuicksightDashboard from '@/components/QuicksightDashboard.vue'

export default {
  components:{
    QuicksightDashboard
  }
  
}
</script>

<style scoped>

</style>
