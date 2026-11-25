import 'package:flutter/material.dart';
import 'package:pbp_flutter/models/project.dart';
import 'package:pbp_flutter/services/api_client.dart';
import 'package:pbp_flutter/services/auth_state.dart';
import 'package:pbp_flutter/widgets/auth_guard.dart';
import 'package:pbp_flutter/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  String _techStack = '';
  String _projectUrl = '';
  String _projectImageUrl = '';
  bool _isSubmitting = false;

  String? _validateUrl(String? value, {bool required = true}) {
    if (value == null || value.trim().isEmpty) {
      if (required) {
        return 'URL tidak boleh kosong!';
      }
      return null;
    }
    final uri = Uri.tryParse(value.trim());
    if (uri == null ||
        !uri.hasScheme ||
        !uri.hasAuthority ||
        !(uri.scheme == 'http' || uri.scheme == 'https')) {
      return 'Masukkan format URL yang valid (contoh: https://example.com)!';
    }
    return null;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final allowed = await ensureLoggedIn(context);
    if (!allowed || !mounted) return;

    final authState = context.read<AuthState>();
    final token = authState.token;
    if (token == null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(content: Text('Anda belum login.')),
        );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    final newProject = Project(
      title: _title.trim(),
      description: _description.trim(),
      techStack: _techStack.trim(),
      projectUrl: _projectUrl.trim(),
      projectImageUrl: _projectImageUrl.trim(),
    );

    try {
      final created = await context.read<ApiClient>().createProject(
            newProject,
            token: token,
          );

      if (!mounted) return;

      showDialog(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: const Text('Proyek berhasil ditambahkan!'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Judul Proyek: ${created.title}'),
                  const SizedBox(height: 4),
                  Text('Deskripsi: ${created.description}'),
                  const SizedBox(height: 4),
                  Text('Tech Stack: ${created.techStack}'),
                  const SizedBox(height: 4),
                  Text('URL Proyek: ${created.projectUrl}'),
                  if (created.projectImageUrl.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text('URL Gambar: ${created.projectImageUrl}'),
                  ],
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(dialogContext);
                  _formKey.currentState?.reset();
                  Navigator.pop(context, true);
                },
              ),
            ],
          );
        },
      );
    } on ApiException catch (e) {
      if (!mounted) return;
      if (e.statusCode == 401) {
        await authState.logout();
        if (!mounted) return;
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              content: Text('Sesi telah berakhir. Silakan login kembali.'),
            ),
          );
        await ensureLoggedIn(context);
      } else {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(
                'Gagal menambahkan proyek (${e.statusCode}): ${e.message}',
              ),
            ),
          );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text('Terjadi kesalahan: $e')),
        );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Project Form'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // === Title ===
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Judul Proyek',
                  labelText: 'Judul Proyek',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (String? value) {
                  _title = value ?? '';
                },
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Judul proyek tidak boleh kosong!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // === Description ===
              TextFormField(
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Deskripsi Proyek',
                  labelText: 'Deskripsi Proyek',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (String? value) {
                  _description = value ?? '';
                },
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Deskripsi proyek tidak boleh kosong!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // === Tech Stack ===
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Contoh: Flutter, Django, PostgreSQL',
                  labelText: 'Tech Stack',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (String? value) {
                  _techStack = value ?? '';
                },
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Tech stack tidak boleh kosong!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // === Project URL ===
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'https://github.com/username/project',
                  labelText: 'Project URL',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                keyboardType: TextInputType.url,
                onChanged: (String? value) {
                  _projectUrl = value ?? '';
                },
                validator: (value) => _validateUrl(value, required: true),
              ),
              const SizedBox(height: 16),

              // === Project Image URL (Optional) ===
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'https://example.com/image.png (Opsional)',
                  labelText: 'Project Image URL (Optional)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                keyboardType: TextInputType.url,
                onChanged: (String? value) {
                  _projectImageUrl = value ?? '';
                },
                validator: (value) => _validateUrl(value, required: false),
              ),
              const SizedBox(height: 24),

              // === Tombol Simpan ===
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: _isSubmitting ? null : _submit,
                child: _isSubmitting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        'Save',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
