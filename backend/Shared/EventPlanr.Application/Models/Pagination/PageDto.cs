namespace EventPlanr.Application.Models.Pagination;

public class PageDto
{
    public int PageNumber { get; set; } = 1;
    public int PageSize { get; set; } = 10;
}
