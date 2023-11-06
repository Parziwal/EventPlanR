namespace EventPlanr.Application.Contracts;

public interface IImageService
{
    Task<string> UploadImage(byte[] imageFile);
    Task DeleteImage(string imageFileName);
}
