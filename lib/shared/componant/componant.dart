import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/modules/webview/web_view_screen.dart';

Widget buildArticleItem(article, context) => InkWell(
  onTap: () {
    navigateTo(context: context,widget: WebViewScreen(article['url']));
  },
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('${article["urlToImage"]}'),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Container(
                height: 120,
                child: Column(
                  //  mainAxisSize: MainAxisSize.min,

                  crossAxisAlignment: CrossAxisAlignment.start,

                  // mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    Expanded(
                      child: Text(
                        '${article["title"]}',
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      "${article["publishedAt"]}",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget articleBuilder(list, context, {isSearch = false}) {
  return ConditionalBuilder(
    condition: list.isNotEmpty,
    builder: (context) => ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) => buildArticleItem(list[index], context),
      separatorBuilder: (context, index) => buildDivider(),
      itemCount: list.length,
    ),
    fallback: (context) => isSearch
        ? Container()
        : const Center(child: CircularProgressIndicator()),
  );
}

Widget buildDivider() => Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey,
      ),
    );

Widget defaultTextFromField({
  required TextEditingController controller,
  required String? Function(String?)? validator,
  required String labelText,
  required Widget? prefixIcon,
  IconData? suffixIcon,
  Function()? onPressedSuffix,
  Function()? onTap,
  TextInputType? type,
// IconData iconSuffix,
  bool isPassword = false,
  Function(String value)? onChange,
  Function(String value)? onFieldSubmitted,
}) =>
    TextFormField(
      keyboardType: type,
      controller: controller,
      onChanged: onChange,
      onFieldSubmitted: onFieldSubmitted,
      validator: validator,
      obscureText: isPassword,
      onTap: onTap,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon != null
            ? IconButton(
                onPressed: onPressedSuffix,
                icon: Icon(suffixIcon),
              )
            : null,
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
    );

void navigateTo({context, widget}) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
