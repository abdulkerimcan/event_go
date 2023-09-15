import 'package:eventgo/core/constants/color_constants.dart';
import 'package:eventgo/core/enums/gender_enum.dart';
import 'package:eventgo/features/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:eventgo/features/edit_profile/cubit/edit_profile_state.dart';
import 'package:eventgo/product/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:kartal/kartal.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> with ShowDateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  UserModel? userModel;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surNameController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                EditProfileCubit(const EditProfileInitialState())),
      ],
      child: BlocConsumer<EditProfileCubit, EditProfileState>(
        listener: (context, state) {
          if (state is EditProfileFailState) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message ?? "error")));
          } else if (state is EditProfileComplete) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Updated Successfuly!")));
          }
        },
        builder: (context, state) {
          return _buildScaffold(context, state);
        },
      ),
    );
  }

  Scaffold _buildScaffold(BuildContext context, EditProfileState state) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Padding(
        padding: context.padding.normal,
        child: FutureBuilder(
          future: context.watch<EditProfileCubit>().getUserInfo(),
          builder: (context, snapshot) {
            if (snapshot.error != null) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasData) {
              var userInfo = snapshot.data;
              nameController.text = userInfo?.name ?? "error";
              surNameController.text = userInfo?.surname ?? "error";
              return Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildImage(context),
                    const Divider(),
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: "Name"),
                    ),
                    TextFormField(
                        controller: surNameController,
                        decoration:
                            const InputDecoration(labelText: "Surname")),
                    _buildGenderDropDown(context),
                    BlocListener<EditProfileCubit, EditProfileState>(
                      listener: (context, state) {
                        if (state is DateState) {
                          birthDateController.text = state.date;
                        }
                      },
                      child: _dateTextField(context, birthDateController.text),
                    ),
                    BlocBuilder<EditProfileCubit, EditProfileState>(
                      builder: (context, state) {
                        if (state is EditProfileLoadingState) {
                          return const CircularProgressIndicator();
                        }
                        return _editBtn(context);
                      },
                    )
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Center _buildImage(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          InkWell(
            onTap: () async {
              await context.read<EditProfileCubit>().selectImage();
            },
            child: CircleAvatar(
                radius: context.sized.height * 0.07,
                foregroundImage: context.read<EditProfileCubit>().image != null
                    ? FileImage(context.watch<EditProfileCubit>().image!)
                    : null),
          ),
          _editIcon()
        ],
      ),
    );
  }

  TextFormField _dateTextField(BuildContext context, String? date) {
    return TextFormField(
      controller: birthDateController,
      readOnly: true,
      decoration: const InputDecoration(
          suffixIcon: Icon(Icons.calendar_month), labelText: "Date of Birth"),
      onTap: () async {
        var pickedDate = await showDate(context, date);
        if (pickedDate != null) {
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          await context.read<EditProfileCubit>().changeDate(formattedDate);
        }
      },
    );
  }

  ElevatedButton _editBtn(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          context
              .read<EditProfileCubit>()
              .update(nameController.text, surNameController.text);
        },
        child: Text(
          "Save Changes",
          style: Theme.of(context)
              .textTheme
              .labelLarge
              ?.copyWith(color: Colors.white),
        ));
  }

  InputDecorator _buildGenderDropDown(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
          contentPadding: context.padding.horizontalNormal,
          labelText: "Gender"),
      child: DropdownButton(
        padding: context.padding.verticalLow,
        isExpanded: true,
        borderRadius: BorderRadius.circular(20),
        value: context.watch<EditProfileCubit>().selectedGender,
        focusNode: FocusNode(),
        underline: Container(
          color: Colors.red,
        ),
        items: GenderEnum.values.map((GenderEnum gender) {
          return DropdownMenuItem<GenderEnum>(
              value: gender, child: Text(gender.name));
        }).toList(),
        onChanged: (GenderEnum? gender) {
          context.read<EditProfileCubit>().changeGender(gender);
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        color: ColorConstants.primaryColor,
        icon: const Icon(FontAwesomeIcons.arrowLeft),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: false,
      title: _buildTitle(context),
    );
  }

  Text _buildTitle(BuildContext context) {
    return Text(
      "Edit Profile",
      style: Theme.of(context)
          .textTheme
          .headlineMedium
          ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
    );
  }

  Positioned _editIcon() {
    return Positioned(
      right: -5,
      bottom: -5,
      child: IconButton(
          onPressed: () {},
          icon: Container(
            width: 30,
            height: 30,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: ColorConstants.primaryColor),
            child: const Icon(
              Icons.edit,
              size: 20,
              color: Colors.white,
            ),
          )),
    );
  }
}

mixin ShowDateMixin {
  Future<DateTime?> showDate(BuildContext context, String? date) async {
    DateTime today = DateTime.now();
    return await showDatePicker(
        context: context,
        initialDate: date.ext.isNotNullOrNoEmpty
            ? DateTime.parse(date!)
            : DateTime(today.year - 18),
        firstDate: DateTime(today.year - 120),
        lastDate: DateTime(today.year - 18));
  }
}
