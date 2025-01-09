
import 'dart:developer';

import 'package:gsheets/gsheets.dart';
import 'package:wallpaper_app/infrastructure/model/category_date_model.dart';
import 'package:wallpaper_app/infrastructure/model/ringtone_data_model.dart';
import 'package:wallpaper_app/infrastructure/model/search_carousel_data_model.dart';
import 'package:wallpaper_app/infrastructure/model/wallpaper_data_model.dart';
import 'package:wallpaper_app/infrastructure/constant/api_constant.dart';
import 'package:wallpaper_app/infrastructure/services/google_sheet_service.dart';

class ApiService {
  // static getWallpapers() async {
  //   final res =
  //       await http.get(Uri.parse(ApiConstant.baseUrl + ApiConstant.wallpaper));
  //
  //   if (res.statusCode == 200) {
  //     return wallpaperDataModelFromJson(res.body);
  //   } else {
  //     throw Exception("Error Fetching Wallpaper Data");
  //   }
  // }

  static Future<List<WallpaperDataModel>> getWallpapers({required int workSheetId}) async {
   try{
     Worksheet? productSheet = await GoogleSheetService.initWallpapers(workSheetId: workSheetId);
     final values = (await productSheet!.values.allRows())
         .skip(1)
         .toList();
     if(workSheetId ==0) {
       log("User wallpaper data value ===> ${values}");
     }
     List<WallpaperDataModel> wallpapers = [];
     for (var data in values) {
       if (data.length == 4) {
         wallpapers.add(WallpaperDataModel.fromSheets(data));
       } else {
       }
     }
     return wallpapers;
   } catch(e){
     Exception(e);
     return [];
   }
  }

  static Future<List<CategoryDataModel>> getCategories() async {
    try{
      Worksheet? productSheet = await GoogleSheetService.initWallpapers(workSheetId: ApiConstant.categoriesSheetId);
      final values = (await productSheet!.values.allRows())
          .skip(1)
          .toList();
      List<CategoryDataModel> categories = [];
      for (var data in values) {
        if (data.length == 3) {
          categories.add(CategoryDataModel.fromSheets(data));
        } else {
        }
      }
      return categories;
    } catch(e){
      Exception(e);
      return [];
    }
  }

  static Future<List<RingtoneDataModel>> getRingtone() async {
    try{
      Worksheet? productSheet = await GoogleSheetService.initWallpapers(workSheetId: ApiConstant.ringtoneSheetId);
      final values = (await productSheet!.values.allRows())
          .skip(1)
          .toList();
      List<RingtoneDataModel> ringtones = [];
      for (var data in values) {
        if (data.length == 4) {
          ringtones.add(RingtoneDataModel.fromSheets(data));
        } else {
        }
      }
      return ringtones;
    } catch(e){
      Exception(e);
      return [];
    }
  }

  static Future<List<SearchCarouselDataModel>> getSearchCarousel() async {
    try{
      Worksheet? productSheet = await GoogleSheetService.initWallpapers(workSheetId: ApiConstant.searchCarouselId);
      final values = (await productSheet!.values.allRows())
          .skip(1)
          .toList();
      List<SearchCarouselDataModel> searchCarouselData = [];
      for (var data in values) {
        searchCarouselData.add(SearchCarouselDataModel.fromSheets(data));
      }
      return searchCarouselData;
    } catch(e){
      Exception(e);
      return [];
    }
  }

}
