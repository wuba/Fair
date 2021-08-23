module.exports = {
  locales: {
    '/': {
      lang: 'en-US',
      title: 'Flutter Fair',
      description: 'A Flutter package used to update widget tree dynamically'
    },
    '/zh/': {
      lang: 'zh-CN',
      title: 'Flutter Fair',
      description: 'Fair是为Flutter设计的，UI&模板动态化框架'
    }
  },
  markdown: {
    lineNumbers: true
  },
  themeConfig: {
    locales:{
      '/':{
        lastUpdated: 'Last Update',
        selectText: 'Languages',
        label: 'English',
        ariaLabel: 'Languages',
        nav: [
          {
            text: 'Sample',
            ariaLabel: 'Sample Menu',
            items: [
              { text: 'Hello Fair', link: '/project/hello_fair/', target:'_blank'}
            ]
           }
        ],
        sidebar: [
                {
                  title: 'Guide',
                  collapsable: false,
                  children: [
                    'guide/',
                    'guide/usage.md',
                    'guide/simple-demo.md',
                    'guide/counting-demo.md',
                  ]
                },
                {
                  title: 'Advance',
                  collapsable: false,
                  children: [
                    'guide/layout_definition.md',
                    'guide/generate_binding.md',
                    'guide/generate_bundle.md',
                    'guide/layout_sugar.md',
                    'guide/sample_dynamic_logic_page.md',
                    'guide/sample_page2page.md',
                    'guide/sample_list_dynamic_cells.md',
                    'guide/sample_list_dynamic.md',
                  ]
                },
            		{
            			title: 'Resource',
            			collapsable: false,
            			children: [
            			  'article/fair_design.md',
            			  'article/widget_update.md',
            			  'article/build_runner.md',
            			  'article/performance.md'
            			]
            		},
              ]
      },
      '/zh/': {
        lastUpdated: '上次更新',
        selectText: '选择语言',
        label: '简体中文',
        nav: [
          {
            text: 'Sample样例',
            ariaLabel: 'Sample Menu',
            items: [
              { text: 'Hello Fair', link: '/project/hello_fair/', target:'_blank'}
            ]
           }
        ],
        sidebar: [
                {
                  title: '指南',
                  collapsable: false,
                  children: [
                    'zh/guide/',
                    'zh/guide/usage.md',
                    'zh/guide/development_environment.md',
                    'zh/guide/simple-demo.md',
                    'zh/guide/counting-demo.md',
                  ]
                },
                {
                  title: '深入',
                  collapsable: false,
                  children: [
                    'zh/guide/layout_definition.md',
                    'zh/guide/generate_binding.md',
                    'zh/guide/generate_bundle.md',
                    'zh/guide/layout_sugar.md',
                    'zh/guide/sample_dynamic_logic_page.md',
                    'zh/guide/sample_page2page.md',
                    'zh/guide/sample_list_dynamic_cells.md',
                    'zh/guide/sample_list_dynamic.md',
                  ]
                },
            		{
            			title: '资料',
            			collapsable: false,
            			children: [
            			  'zh/article/fair_design.md',
            			  'zh/article/widget_update.md',
            			  'zh/article/build_runner.md',
            			  'zh/article/performance.md'
            			]
            		},
              ]
      }
    },

	  smoothScroll: true,
	  repo: 'wuba/fair'
  }
}
