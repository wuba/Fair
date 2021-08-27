<template>
  <div>
  <header style="position:fixed;left:0;top:0;width:100%;font-size:14px;line-height:40px;text-align:center;background-color:rgb(217,70,88);color:#ffffff;z-index:20;">
  Fair 2.0 release！ <a style="color:#4ea2f1" v-bind:href="whatIsNewUrl">What’s new</a>
  </header>
  <ParentLayout>
  </ParentLayout>
  </div>
</template>
<style>
  .navbar {
    top: 40px;
  }

  .sidebar {
    top: 5rem;
  }
  
  @media (max-width: 719px) {
    .sidebar {
      top: 3rem;
    }
  }

  .theme-default-content.content__default {
    padding-top: 4rem;
  }
</style>
<script>
import ParentLayout from '@parent-theme/layouts/Layout.vue'
export default {
  name: 'Layout',
  components: {
    ParentLayout,
  },
  computed: {
    whatIsNewUrl: function() {
      return (this.$lang == 'zh-CN' ? '/zh' : '') + '/guide/whats_new.html';
    }
  }
}
</script>