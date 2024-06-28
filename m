Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88579F519
	for <netfs@lists.linux.dev>; Fri, 28 Jun 2024 07:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719559842; cv=none; b=rgsRb4e+ZV7BQKZonFJ9vwTpRWIVVMViIylEbsIi1HgAPY5/Yo24z93Xlf5MuasFR+qC8fCU51gkX3XEPePRcTG2NCXMzxzz8B9NrNG+LQrd/oUSswna/h0qeXRIwybLf+RhbzZRDRoLEvtvIvSfri/d6/us08vhSoLNrIqbEzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719559842; c=relaxed/simple;
	bh=9DjJsXx99iqs0CwhlzUJW8Y4ZcRpPL1NAmZ/+KNhQn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tPHvbteXs5rn6LcDnk/xUeoR3B0haxbsT56EXz6jqw9AIw5Qxu0oTdRBmUihyQky5wyQKvqqjYbHillmx0UlbUrLKXPkp4PNGKd361HGPrvY8Tlb+2dchD7GnSrZvmSAxvtwILSeseQWPd1GukfeWIvoSv6nvDpiZmtKyO0XSQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Nb8OWQLg; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Nb8OWQLg"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719559837; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=eyQs0tMPU81R2eg4ZErSJAcR3SHyXy5n22wLWs/5v64=;
	b=Nb8OWQLguMXl+MDHpJ/x0yyIJANIepdj6E/cKQL4N1LPEmrlkzW2i+USMs5CmbtfqnQnBExHfAmdGcWEwDeP8ldVxuM5mNl28VszkGJ1rKOr+z0bQrov6S8yw1bl2HLKEvFbGYpzD17lj1wHMOIbdyyzXxG2rjpAmUHnU9N7LEU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033023225041;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W9PYgHp_1719559835;
Received: from 30.97.48.160(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W9PYgHp_1719559835)
          by smtp.aliyun-inc.com;
          Fri, 28 Jun 2024 15:30:36 +0800
Message-ID: <47a91a45-7e36-45e0-891f-475adca77f59@linux.alibaba.com>
Date: Fri, 28 Jun 2024 15:30:35 +0800
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/9] cachefiles: propagate errors from vfs_getxattr()
 to avoid infinite loop
To: libaokun@huaweicloud.com, netfs@lists.linux.dev, dhowells@redhat.com,
 jlayton@kernel.org
Cc: jefflexu@linux.alibaba.com, zhujia.zj@bytedance.com,
 linux-erofs@lists.ozlabs.org, brauner@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 yangerkun@huawei.com, houtao1@huawei.com, yukuai3@huawei.com,
 wozizhi@huawei.com, Baokun Li <libaokun1@huawei.com>
References: <20240628062930.2467993-1-libaokun@huaweicloud.com>
 <20240628062930.2467993-5-libaokun@huaweicloud.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240628062930.2467993-5-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/6/28 14:29, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> In cachefiles_check_volume_xattr(), the error returned by vfs_getxattr()
> is not passed to ret, so it ends up returning -ESTALE, which leads to an
> endless loop as follows:
> 
> cachefiles_acquire_volume
> retry:
>    ret = cachefiles_check_volume_xattr
>      ret = -ESTALE
>      xlen = vfs_getxattr // return -EIO
>      // The ret is not updated when xlen < 0, so -ESTALE is returned.
>      return ret
>    // Supposed to jump out of the loop at this judgement.
>    if (ret != -ESTALE)
>        goto error_dir;
>    cachefiles_bury_object
>      //  EIO causes rename failure
>    goto retry;
> 
> Hence propagate the error returned by vfs_getxattr() to avoid the above
> issue. Do the same in cachefiles_check_auxdata().
> 
> Fixes: 32e150037dce ("fscache, cachefiles: Store the volume coherency data")
> Fixes: 72b957856b0c ("cachefiles: Implement metadata/coherency data storage in xattrs")
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

It looks good to me,
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
