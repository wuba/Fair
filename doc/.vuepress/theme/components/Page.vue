<template>
  <ParentLayout>
      <template #bottom>
          <footer class="cp_footer">Copyright © 2020 58.com | Powered by The Fair Authors</footer>
      </template>
  </ParentLayout>
</template>
<style>
.theme-container .page {
    padding-bottom: 1rem;
}
.page .cp_footer {
    text-align: center;
    padding: 1rem 0 0 0;
    font-size: 14px;
    color: #4e6e8e;
    border-top: 1px solid #eaecef;
}
</style>
<script>
import ParentLayout from '@parent-theme/components/Page.vue'

export default {
  components: {
    ParentLayout,
  }
}
</script>