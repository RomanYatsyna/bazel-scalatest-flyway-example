# Do not edit. bazel-deps autogenerates this file from dependencies.yaml.
def _jar_artifact_impl(ctx):
    jar_name = "%s.jar" % ctx.name
    ctx.download(
        output = ctx.path("jar/%s" % jar_name),
        url = ctx.attr.urls,
        sha256 = ctx.attr.sha256,
        executable = False
    )
    src_name = "%s-sources.jar" % ctx.name
    srcjar_attr = ""
    has_sources = len(ctx.attr.src_urls) != 0
    if has_sources:
        ctx.download(
            output = ctx.path("jar/%s" % src_name),
            url = ctx.attr.src_urls,
            sha256 = ctx.attr.src_sha256,
            executable = False
        )
        srcjar_attr = '\n    srcjar = ":%s",' % src_name

    build_file_contents = """
package(default_visibility = ['//visibility:public'])
java_import(
    name = 'jar',
    tags = ['maven_coordinates={artifact}'],
    jars = ['{jar_name}'],{srcjar_attr}
)
filegroup(
    name = 'file',
    srcs = [
        '{jar_name}',
        '{src_name}'
    ],
    visibility = ['//visibility:public']
)\n""".format(artifact = ctx.attr.artifact, jar_name = jar_name, src_name = src_name, srcjar_attr = srcjar_attr)
    ctx.file(ctx.path("jar/BUILD"), build_file_contents, False)
    return None

jar_artifact = repository_rule(
    attrs = {
        "artifact": attr.string(mandatory = True),
        "sha256": attr.string(mandatory = True),
        "urls": attr.string_list(mandatory = True),
        "src_sha256": attr.string(mandatory = False, default=""),
        "src_urls": attr.string_list(mandatory = False, default=[]),
    },
    implementation = _jar_artifact_impl
)

def jar_artifact_callback(hash):
    src_urls = []
    src_sha256 = ""
    source=hash.get("source", None)
    if source != None:
        src_urls = [source["url"]]
        src_sha256 = source["sha256"]
    jar_artifact(
        artifact = hash["artifact"],
        name = hash["name"],
        urls = [hash["url"]],
        sha256 = hash["sha256"],
        src_urls = src_urls,
        src_sha256 = src_sha256
    )
    native.bind(name = hash["bind"], actual = hash["actual"])


def list_dependencies():
    return [
    {"artifact": "org.checkerframework:checker-qual:3.5.0", "lang": "java", "sha1": "2f50520c8abea66fbd8d26e481d3aef5c673b510", "sha256": "729990b3f18a95606fc2573836b6958bcdb44cb52bfbd1b7aa9c339cff35a5a4", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/checkerframework/checker-qual/3.5.0/checker-qual-3.5.0.jar", "source": {"sha1": "acb4745ac343906cd39f9b3776db0e56f251ae6e", "sha256": "0724b40995c1b05516caa2dd9a3b2f5378f948cf20f3404f4db316af25239368", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/checkerframework/checker-qual/3.5.0/checker-qual-3.5.0-sources.jar"} , "name": "org_checkerframework_checker_qual", "actual": "@org_checkerframework_checker_qual//jar", "bind": "jar/org/checkerframework/checker_qual"},
    {"artifact": "org.flywaydb:flyway-core:8.5.5", "lang": "java", "sha1": "eb040b3b4acebb9517e0e01120d27e11ca417fb1", "sha256": "78232bbba8ce4fa14e7da24ede84a402832953b7c4619b167eb972a2ff2d2b1d", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/flywaydb/flyway-core/8.5.5/flyway-core-8.5.5.jar", "source": {"sha1": "029ec67db4a939c444e30b8ec9c83d4aa2602648", "sha256": "e467f7bd2900e7605666a9d449c97e5e5dd78acbbc5ce6213215ef8397b01a8e", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/flywaydb/flyway-core/8.5.5/flyway-core-8.5.5-sources.jar"} , "name": "org_flywaydb_flyway_core", "actual": "@org_flywaydb_flyway_core//jar", "bind": "jar/org/flywaydb/flyway_core"},
    {"artifact": "org.postgresql:postgresql:42.3.3", "lang": "java", "sha1": "6f639af368afda4c5a3e77a6299262c501e67076", "sha256": "eed0604f512ba44817954de99a07e2a5470aa4bfcb481d4e63a93e0ff0e0aede", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/postgresql/postgresql/42.3.3/postgresql-42.3.3.jar", "source": {"sha1": "cdb7e97473563d1333fa1267ef249b3ccf237457", "sha256": "70be65dd20ddda143a8fa435b1bafc912dc806e3f609b84287d40e55e9e9c6b8", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/postgresql/postgresql/42.3.3/postgresql-42.3.3-sources.jar"} , "name": "org_postgresql_postgresql", "actual": "@org_postgresql_postgresql//jar", "bind": "jar/org/postgresql/postgresql"},
    ]

def maven_dependencies(callback = jar_artifact_callback):
    for hash in list_dependencies():
        callback(hash)
