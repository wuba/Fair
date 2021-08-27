<template>
  <div>
  <header style="position:fixed;left:0;top:0;width:100%;font-size:14px;line-height:40px;text-align:center;background-color:rgb(217,70,88);color:#ffffff;">
  Fair 2.0 release！ <a style="color:#4ea2f1" href="./guide/whats_new">What’s new</a>
  </header>
  <ParentLayout>
  </ParentLayout>
  </div>
</template>
<style>
  .navbar {
    top: 40px;
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