require_relative "./helper"

class TestStrategy < Minitest::Test
  include Linguist

  BlobStub = Struct.new(:name)

  def test_extension_trims_example_suffix
    blob = BlobStub.new("README.md.example")

    assert_equal [Language["Markdown"]], Strategy::Extension.call(blob, [])
  end

  def test_filename_trims_example_suffix
    blob = BlobStub.new(".env.example")

    assert_equal [Language["Dotenv"]], Strategy::Filename.call(blob, [])
  end

  def test_extension_and_filename_preserve_non_example_names
    extension_blob = BlobStub.new("README.md")
    filename_blob = BlobStub.new(".env")

    assert_equal [Language["Markdown"]], Strategy::Extension.call(extension_blob, [])
    assert_equal [Language["Dotenv"]], Strategy::Filename.call(filename_blob, [])
  end

  def test_example_suffix_is_case_insensitive
    blob = BlobStub.new("README.md.EXAMPLE")

    assert_equal [Language["Markdown"]], Strategy::Extension.call(blob, [])
  end
end
