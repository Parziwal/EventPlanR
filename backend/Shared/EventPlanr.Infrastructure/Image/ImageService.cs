using Amazon;
using Amazon.S3;
using Amazon.S3.Model;
using EventPlanr.Application.Contracts;
using EventPlanr.Infrastructure.Options;
using Microsoft.Extensions.Options;

namespace EventPlanr.Infrastructure.Image;

public class ImageService : IImageService
{
    private readonly IAmazonS3 _bucket;
    private readonly S3BucketOptions _bucketOptions;

    public ImageService(IAmazonS3 bucket, IOptions<S3BucketOptions> bucketOptions)
    {
        _bucket = bucket;
        _bucketOptions = bucketOptions.Value;
    }

    public async Task<string> UploadImage(byte[] imageFile)
    {
        var imageName = $"{Guid.NewGuid()}.png";

        await using var imageFileStream = new MemoryStream(imageFile);

        var putObject = new PutObjectRequest()
        {
            BucketName = _bucketOptions.EventPlanrImagesBucket,
            Key = imageName,
            ContentType = "image/png",
            InputStream = imageFileStream,
        };

        await _bucket.PutObjectAsync(putObject);
        var itemUrl = $"https://{_bucketOptions.EventPlanrImagesBucket}.s3.{RegionEndpoint.USEast1.SystemName}.amazonaws.com/" + imageName;
        return itemUrl;
    }

    public async Task DeleteImage(string imageFileName)
    {
        var deleteImageRequest = new DeleteObjectRequest
        {
            BucketName = _bucketOptions.EventPlanrImagesBucket,
            Key = imageFileName,
        };

        await _bucket.DeleteObjectAsync(deleteImageRequest);
    }
}
