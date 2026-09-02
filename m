Received: from mta1.migadu.com (out-15.mta1.migadu.com [95.215.58.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E154CCDD7
	for <netfs@lists.linux.dev>; Wed,  2 Sep 2026 07:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788335584; cv=none; b=iltmONC4ze8LJeMaIeB7ypOu/x1AG9Odez1y5Si0hp/UniLfHblzFIbvyjClNOvVioEuAsHEGDpnrxOGgeLStbC5TodJ5SqdW5bd7R9DidBidvU8EuWNcY/7FllJ7ERU++uG1RzJq9IU6IOwed2VnTI6GYfMOv55dLgt3OoNMDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788335584; c=relaxed/simple;
	bh=0hHJnYnmmxdQnBE62IYdnAJ07bnulKayv319f4QreN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kCosDGgjAa2zUl+abcBZfKZnfcy9qEoJmuVjKUPpPSWLoDI85SYsFyI5mgFqoM1iEw7ONCJLQlthpBjHsMDdQY1Dr3bnrzWVQeoa/qYWfyU+4vOwU3SBfwpukFM2OtZQuxEIDmrIEIl3flgc2tv6KiQQurUFhz422jzDhPpK9ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h5C88ewj; arc=none smtp.client-ip=95.215.58.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h5C88ewj"
X-Envelope-To: netfs@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=0hHJnYnmmxdQnBE62IYdnAJ07bnulKayv319f4QreN8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788335580; v=1; x=1788940380;
 b=h5C88ewjebrJQ0/5pVDc1dLFW+XBCB0TsoGdQLRvhE2TQML95IzWJGOi1eWO9+DjbR3dmhtK
 bQEklHB1Xj1y3GQk1nFulbOwsC8Jt/d144UoqBD40yVJxA2Yz9XrEzaHNem6h9i96xQjV7Kx28B
 bLmwKErP6VOw/ZQDso8gFnBs=
X-Envelope-To: netfs@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 711dfb84e95fb698;
	Wed, 02 Sep 2026 07:53:00 +0000
X-Mizu-Trace-ID: 711dfb84e95fb698
X-Migadu-Flow: FLOW_OUT
Message-ID: <a4c0f3b9-4df0-4538-903e-b7af4fb0e32f@linux.dev>
Date: Wed, 2 Sep 2026 15:52:54 +0800
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cachefiles: Fix path of the "debug" module parameter in
 help paragraph
To: netfs@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: dhowells@redhat.com, brauner@kernel.org
References: <20260620131425.8210-1-zenghui.yu@linux.dev>
Content-Language: en-US
From: Zenghui Yu <zenghui.yu@linux.dev>
In-Reply-To: <20260620131425.8210-1-zenghui.yu@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/20/26 9:14 PM, Zenghui Yu wrote:
> The correct path of the "debug" module parameter should be
> /sys/module/cachefiles/parameters/debug. Fix it.
> 
> Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
> ---
>  fs/cachefiles/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/cachefiles/Kconfig b/fs/cachefiles/Kconfig
> index c5a070550ee3..1f0ec7d287b9 100644
> --- a/fs/cachefiles/Kconfig
> +++ b/fs/cachefiles/Kconfig
> @@ -17,7 +17,7 @@ config CACHEFILES_DEBUG
>  	help
>  	  This permits debugging to be dynamically enabled in the filesystem
>  	  caching on files module.  If this is set, the debugging output may be
> -	  enabled by setting bits in /sys/modules/cachefiles/parameter/debug or
> +	  enabled by setting bits in /sys/module/cachefiles/parameters/debug or
>  	  by including a debugging specifier in /etc/cachefilesd.conf.
>  
>  config CACHEFILES_ERROR_INJECTION

ping?
