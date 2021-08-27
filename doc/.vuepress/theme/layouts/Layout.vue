<template>
  <div>
  <header style="position:fixed;left:0;top:0;width:100%;font-size:14px;line-height:24px;text-align:center;background-color:rgb(255,229,100);color:#6b5900;">公告栏</header>
  <ParentLayout>
  </ParentLayout>
  </div>
</template>
<style>
  .navbar {
    top: 24px;
  }
</style>
<script>
import ParentLayout from '@parent-theme/layouts/Layout.vue'
export default {
  name: 'Layout',
  components: {
    ParentLayout,
  }
}
</script>