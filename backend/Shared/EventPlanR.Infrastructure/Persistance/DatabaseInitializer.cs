using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;

namespace EventPlanr.Infrastructure.Persistance;

public static class InitialiserExtensions
{
    public static async Task InitializeDatabaseAsync(this IServiceCollection services)
    {
        using var scope = services.BuildServiceProvider().CreateScope();

        var initialiser = scope.ServiceProvider.GetRequiredService<DatabaseInitializer>();
        await initialiser.MigrateAsync();
        await initialiser.SeedAsync();
    }
}

public class DatabaseInitializer
{
    private readonly EventPlanrDbContext _context;

    public DatabaseInitializer(EventPlanrDbContext context)
    {
        _context = context;
    }

    public async Task MigrateAsync()
    {
        await _context.Database.MigrateAsync();
    }

    public async Task SeedAsync()
    {
        // Test data
    }
}
