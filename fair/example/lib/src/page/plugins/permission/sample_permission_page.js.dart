part of 'sample_permission_page.dart';

bool isGranted = false;
String picUrl = '/storage/emulated/0/Android/data/fair.example/files/Pictures/80e10da6-2599-4935-b26b-ae59857fdf175734646925196256918.jpg';

void requestPermission() {
  WBPermission().requestPermission({
    'pageName': '#FairPageName#',
    'args': {
      'type': 'Permission_Photo',
      'Granted': (resp) {
        isGranted = true;
        takePhoto();
      },
      'Restricted': (resp) {
        isGranted = false;
        takePhoto();
      },
    }
  });
}

void selectFromAlbum() {
  FairPhotoSelector().getPhoto({
    'pageName': '#FairPageName#',
    'args': {
      'type': 'album',
      'success': (resp) {
        picUrl = resp;
        setData('#FairPageName#', {
          'picUrl': resp,
        });
      },
      'failure': () {
        //用户获取图片失败
      },
    }
  });
}

void takePhoto() {
  FairPhotoSelector().getPhoto({
    'pageName': '#FairPageName#',
    'args': {
      'type': 'photo',
      'success': (resp) {
        picUrl = resp;
        setData('#FairPageName#', {
          'picUrl': resp,
        });
      },
      'failure': () {
        //用户获取图片失败
      },
    }
  });
}
