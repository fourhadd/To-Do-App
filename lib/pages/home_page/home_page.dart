// pages/home_page/home_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/l10n/app_localizations.dart';
import 'package:todo/pages/add_task_page/addTaskPage.dart';
import 'package:todo/widgets/common_widgets.dart';
import 'package:todo/pages/home_page/home_page_widgets.dart';
import 'package:todo/pages/profile_page/profile.dart';
import 'package:todo/pages/task_info_page/task_info_page.dart';
import 'package:todo/theme/app_color.dart';
import 'package:todo/utils/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TodoProvider>();
    final tasks = provider.tasks;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.h,
        actionsPadding: EdgeInsets.symmetric(horizontal: 24.w),
        leadingWidth: 80.w,
        backgroundColor: Colors.black,
        title: MainText(
          text: AppLocalizations.of(context)!.appName,
          fontSize: 20.sp,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
          iconSize: 30.sp,
          color: Colors.white.withValues(alpha: 0.87),
        ),
        actions: [
          Container(
            width: 42.w,
            height: 42.h,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(50.r),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 80.h,
        color: AppColor.cardColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            navItem(
              icon: Icons.home_outlined,
              label: AppLocalizations.of(context)!.home,
            ),
            navItem(
              icon: Icons.calendar_month_outlined,
              label: AppLocalizations.of(context)!.calendar,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile()),
                );
              },
              child: navItem(
                icon: Icons.person_outline_outlined,
                label: AppLocalizations.of(context)!.profile,
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: SizedBox(
        width: 64.w,
        height: 64.h,
        child: FloatingActionButton(
          onPressed: () async {
            await showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: AppColor.cardColor,
              context: context,
              builder: (context) => AddtaskPage(TodoItems: provider.todos),
            );
          },
          backgroundColor: AppColor.secondaryColor,
          shape: CircleBorder(),
          child: Icon(Icons.add, color: Colors.white, size: 28.sp),
        ),
      ),
      body: SafeArea(
        child: tasks.isEmpty
            ? emptyScreen()
            : ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 8.h,
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        final delete = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TaskInfo(
                              task: task,
                              index: index,
                              tasks: tasks,
                            ),
                          ),
                        );

                        if (delete == true) {
                          final confirmDelete = await showDialog<bool>(
                            barrierDismissible: true,
                            context: context,
                            builder: (context) => Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24.w),
                              child: deleteQueryDialog(task: task),
                            ),
                          );
                          if (confirmDelete == true) {
                            await context.read<TodoProvider>().deleteTask(task);
                          }
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: AppColor.cardColor,
                        ),
                        height: 72.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Center(
                                  child: Checkbox(
                                    shape: CircleBorder(),
                                    value: task.isDone,
                                    onChanged: (value) {
                                      context.read<TodoProvider>().toggleTask(
                                        task.id,
                                        value!,
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MainText(text: task.title, fontSize: 16.sp),
                                    SizedBox(height: 6.h),
                                    MainText(
                                      text: task.formattedDueTime,
                                      fontSize: 14.sp,
                                      color: Colors.white.withValues(
                                        alpha: 0.87,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                TaskCategoryView(task: task),
                                SizedBox(width: 16.w),
                                TaskPriorityView(task: task),
                                SizedBox(width: 10.w),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
