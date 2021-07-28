GLOBAL['#FairPageName#'] = (function (__initProps__) {
    const __global__ = this;
    return {
        isGranted: false, picUrl: '', requestPermission: function requestPermission() {
            const __thiz__ = this;
            with (__thiz__) {
                WBPermission().requestPermission(convertObjectLiteralToSetOrMap({
                    ['pageName']: '#FairPageName#',
                    ['args']: convertObjectLiteralToSetOrMap({
                        ['type']: 'Permission_Photo',
                        ['Granted']: function dummy(resp) {
                            isGranted = true;
                            takePhoto();
                        },
                        ['Restricted']: function dummy(resp) {
                            isGranted = false;
                            takePhoto();
                        },
                    }),
                }));
            }
        }, selectFromAlbum: function selectFromAlbum() {
            const __thiz__ = this;
            with (__thiz__) {
                FairPhotoSelector().getPhoto(convertObjectLiteralToSetOrMap({
                    ['pageName']: '#FairPageName#',
                    ['args']: convertObjectLiteralToSetOrMap({
                        ['type']: 'album', ['success']: function dummy(resp) {
                            picUrl = resp;
                            setData('#FairPageName#',{'picUrl':resp});
                        }, ['failure']: function dummy() {
                        },
                    }),
                }));
            }
        }, takePhoto: function takePhoto() {
            const __thiz__ = this;
            with (__thiz__) {
                FairPhotoSelector().getPhoto({
                    ['pageName']: '#FairPageName#',
//                     ['args']: convertObjectLiteralToSetOrMap({
//                         ['type']: 'photo', ['success']: function dummy(resp) {
//                             picUrl = resp;
//                             setData('#FairPageName#', convertObjectLiteralToSetOrMap({['picUrl']: resp,}));
//                         }, ['failure']: function dummy() {
//                         },
//                     }),
                    ['args']: {
                        'type': 'photo',
                        'success': function dummy(resp) {
                            console.log('resp'+resp);
                            picUrl = resp;
                            setData('#FairPageName#', {picUrl:'resp'});
                        },
                        'failure': function dummy() {
                        },
                    }
                });
            }
        },
    };
})(convertObjectLiteralToSetOrMap(JSON.parse('#FairProps#')));
