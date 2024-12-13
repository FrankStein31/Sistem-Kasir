<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Transaction;
use App\Models\Product;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class LaporanController extends Controller
{
    public function index(Request $request)
    {
        $filter = $request->get('filter', 'monthly');
        
        $totalRevenue = $this->getTotalRevenue($filter);
        $dailyRevenue = $this->getDailyRevenue($filter);
        $monthlyRevenue = $this->getMonthlyRevenue($filter);
        $yearlyRevenue = $this->getYearlyRevenue($filter);
        
        $productSales = $this->getProductSales($filter);
        $productRankings = $this->getProductRankings($filter);

        return view('content.laporan.index', compact(
            'totalRevenue', 
            'dailyRevenue', 
            'monthlyRevenue', 
            'yearlyRevenue', 
            'productSales',
            'productRankings', 
            'filter'
        ));
    }

    private function getTotalRevenue($filter)
    {
        $query = Transaction::query();
        $query = $this->applyTimeFilter($query, $filter);
        return $query->sum('total');
    }

    private function getDailyRevenue($filter)
    {
        $query = Transaction::select(
            DB::raw('DATE(created_at) as date'),
            DB::raw('SUM(total) as total_revenue'),
            DB::raw('SUM(qty) as total_quantity')
        );
        $query = $this->applyTimeFilter($query, $filter);
        return $query->groupBy('date')
            ->orderBy('date', 'DESC')
            ->get();
    }

    private function getMonthlyRevenue($filter)
    {
        $query = Transaction::select(
            DB::raw('YEAR(created_at) as year'),
            DB::raw('MONTH(created_at) as month'),
            DB::raw('SUM(total) as total_revenue'),
            DB::raw('SUM(qty) as total_quantity')
        );
        $query = $this->applyTimeFilter($query, $filter);
        return $query->groupBy('year', 'month')
            ->orderBy('year', 'DESC')
            ->orderBy('month', 'DESC')
            ->get();
    }

    private function getYearlyRevenue($filter)
    {
        $query = Transaction::select(
            DB::raw('YEAR(created_at) as year'),
            DB::raw('SUM(total) as total_revenue'),
            DB::raw('SUM(qty) as total_quantity')
        );
        $query = $this->applyTimeFilter($query, $filter);
        return $query->groupBy('year')
            ->orderBy('year', 'DESC')
            ->get();
    }

    private function getProductSales($filter)
    {
        $query = Transaction::select(
            'products.name',
            DB::raw('SUM(transactions.qty) as total_quantity'),
            DB::raw('SUM(transactions.total) as total_revenue')
        )
        ->join('products', 'transactions.product_id', '=', 'products.product_id');
        
        $query = $this->applyTimeFilter($query, $filter);
        
        return $query->groupBy('products.name')
            ->orderBy('total_revenue', 'DESC')
            ->get();
    }

    private function getProductRankings($filter)
    {
        $query = Transaction::select(
            'products.name',
            DB::raw('SUM(transactions.qty) as total_quantity'),
            DB::raw('SUM(transactions.total) as total_revenue')
        )
        ->join('products', 'transactions.product_id', '=', 'products.product_id');
        
        $query = $this->applyTimeFilter($query, $filter);
        
        return $query->groupBy('products.name')
            ->orderBy('total_quantity', 'DESC')
            ->limit(10)
            ->get();
    }

    private function applyTimeFilter($query, $filter)
    {
        switch ($filter) {
            case 'weekly':
                return $query->whereBetween('transactions.created_at', [
                    Carbon::now()->startOfWeek(),
                    Carbon::now()->endOfWeek()
                ]);
    
            case 'yearly':
                return $query->whereYear('transactions.created_at', Carbon::now()->year);
    
            case 'monthly':
            default:
                return $query->whereMonth('transactions.created_at', Carbon::now()->month)
                      ->whereYear('transactions.created_at', Carbon::now()->year);
        }
    }
}