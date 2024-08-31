import 'package:flutter/material.dart';
import 'package:money_manager/utils/app_colors.dart';
import 'package:money_manager/viewModels/category_viewModel.dart';
import 'package:money_manager/widgets/input_field.dart';
import 'package:money_manager/widgets/type_selector.dart';
import 'package:provider/provider.dart';
class CategoryManager extends StatelessWidget {
  const CategoryManager({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child:Consumer<CategoryViewModel>(
            builder: (_, vm ,child)
                {
                  vm.getCategories();
                  return  Column(
                    children: [
                      TypeSelector(
                        onSelect: (val)
                        {
                          vm.selectedType =val;
                        },
                        selectedType: vm.selectedType,
                      ),
                       InputFiled(
                          controller: vm.nameController,
                         hintText: "Enter category Name",
                         preIcon: const Icon(Icons.category),
                         onTap: (){
                            // if(vm.nameController == null){
                            //   return true;
                            //   print(vm.nameController.text.length);
                            // }
                         },
                      ),
                      SizedBox(
                        width: double.maxFinite,
                        child: ElevatedButton(
                          onPressed: ()
                          {
                           if(vm.update==true)
                             {
                               vm.updateCategory();
                             }
                           else
                             {
                               vm.saveCategory();
                             }
                          },
                          child: const Text("Save Data"),
                        ),
                      ),
                      const SizedBox(height: 20,),
                        vm.categories.isEmpty ?
                            const Center(
                              child: Padding(
                                padding:EdgeInsets.all(20.0),
                                child: Text("No categories found",
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                              ),
                            ):
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.primaryColor)
                          ),
                          columns: const[
                            DataColumn(label: Text("#"),),
                            DataColumn(label: Text("Type"),),
                            DataColumn(label: Text("Category"),),
                            DataColumn(label: Text("Edit"),),
                            DataColumn(label: Text("Delete"),),
                          ],
                          rows: vm.categories.map((e)
                          {
                            return DataRow(cells: [
                              DataCell(Text("${vm.categories.indexOf(e)+1}")),
                              DataCell(Text("${e.type}")),
                              DataCell(Text("${e.name}")),
                              DataCell(IconButton(
                                onPressed:(){
                                    vm.loadData(e);
                                },
                              icon: const Icon(Icons.edit,color: Colors.blue,),)
                              ),
                              DataCell(IconButton(
                                onPressed:(){
                                  showDialog(
                                      context: context,
                                      builder: (context)
                                      {
                                        return AlertDialog(
                                          icon: const Icon(Icons.delete_forever, color: Colors.red,),
                                          title: const Text("Confirm Delete"),
                                          content: const Text("Do you want to delete this record"),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: ()
                                              {
                                                vm.deleteCategory(e);
                                                Navigator.pop(context, true);
                                              },
                                              child: const Text("Yes"),
                                            ),
                                            TextButton(
                                                onPressed:()
                                                {
                                                  Navigator.pop(context, false);
                                                },
                                                child: const Text("No")
                                            )
                                          ],
                                        );
                                      }
                                  );
                                },
                                icon: const Icon(Icons.delete,color: Colors.red,),)
                              ),
                            ]);
                          }).toList(),
                        ),
                      )
                    ],
                  );
                }
        )
      ),
    );
  }
}
