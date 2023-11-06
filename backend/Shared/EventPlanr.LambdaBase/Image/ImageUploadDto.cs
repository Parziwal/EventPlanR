using Microsoft.AspNetCore.Http;

namespace EventPlanr.LambdaBase.Image;

public class ImageUploadDto
{
    public IFormFile ImageFile { get; set; } = null!;
}
