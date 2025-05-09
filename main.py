import dlt
from dlt.sources.filesystem import filesystem, read_jsonl


def main():
    pipeline = dlt.pipeline(
        pipeline_name="pipeline_name",
        destination="postgres",
        dataset_name="dataset_schema",
        progress="log"
    )
    pipeline.run(raw_data())


@dlt.source(name="source_name")
def raw_data():
    filesystem_config = {
        "file_glob": f"**/*.jsonl",
    }
    pipe = filesystem(**filesystem_config)
    pipe |= read_jsonl()
    yield pipe.with_name(f"pipe__name")


if __name__ == '__main__':
    main()
