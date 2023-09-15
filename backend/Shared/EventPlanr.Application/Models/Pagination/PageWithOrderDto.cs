namespace EventPlanr.Application.Models.Pagination;

public class PageWithOrderDto : PageDto
{
    public string? OrderBy { get; set; }
    public OrderDirection? OrderDirection { get; set; }
}
