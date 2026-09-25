Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DC336D500;
	Fri, 25 Sep 2026 14:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790345623; cv=none; b=WYVw7hMqpGjvMuaKntwusbLfAkza/mJ1LrYz/hE5jotoTyOnnJxoKz+y3zhWxCEha6EcgZ6Fy1sNydZC5OBZonS5JkPSaTZX3qE09zVgGepvO/++kvTWTG/ZY3//1AioVsTiU3+ofQjBgdbdRfTX1+VBg/D3I95H/4nc7kA8vW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790345623; c=relaxed/simple;
	bh=oClpMfyCi2HiAb8UcIX1oTS6ji4pcSfYqVg9OHiKiJk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Tf9p0+fv2uMjJJ/JPDk9VOQ3TPFf6XTrE2XMVVU6U7dJzmIJgfUfT/vbz3hPZIeciKFPepTzQV9UuDUhEoUxLOZRILkgT5MPX6jGxbHquko1hEkY1VAp5ykWTiE17fC/qLLG8DlGUaXnvrH/y+tW5OhrqOElTTyK3xjzd++w420=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TE0jYy4K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TE0jYy4K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F211F000FF;
	Fri, 25 Sep 2026 14:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790345622;
	bh=mANS264NYeza8gjWBDmAZ1xP2F5I89+RvMnNgE1IP8Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=TE0jYy4Ko0ggxcvBoX+6Z6FzV15s08o2lL5hKT8HIg0G8bXEN+GBd5b8HUIEiM+Jt
	 kU01M7kv7uzs15YFnbD9/uQjKL83hhqB/YjDDyBAxkhJ94DNwkMJJvWg9EZmPw1rvW
	 wxNdLDHCfVxKeW2rEc5Ul3IHcpgv0uF6wIwnWHf/GjSd2jwdiKVgsbrXbCrcn5HbgV
	 pWhp0a/+xWOtoPc5fDZVLFEhbTN0eewqnHEbqArD+KYvYeeEUIpVfWVezeowxeaRJd
	 YW92TCIPSdUsJ5AJjZVGHXQQpGOKqAPCJekbMJwcOqDEBZkR2yotUKO2gZ4G5EFk4P
	 2miimJ1SKeGaw==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>, Paulo Alcantara <pc@manguebit.org>, 
 Jonathan Corbet <corbet@lwn.net>, Karl Mehltretter <kmehltretter@gmail.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, netfs@lists.linux.dev, 
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260912073444.51152-1-kmehltretter@gmail.com>
References: <20260912073444.51152-1-kmehltretter@gmail.com>
Subject: Re: [PATCH] netfs: Document the remote size member and its
 accessors
Message-Id: <20260925-forcieren-karnickel-waden-1037e619b6a7@brauner>
Date: Fri, 25 Sep 2026 16:13:36 +0200
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=904; i=brauner@kernel.org;
 h=from:subject:message-id; bh=oClpMfyCi2HiAb8UcIX1oTS6ji4pcSfYqVg9OHiKiJk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRta5w0/+INa1+9KLmcr1cE5jOu0/uWsPHZffa5vfs62
 7Yd4/u7taOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi+iEM/wyeBl+JO3Fh+yQz
 nn8bvh5P7iuTjv2rM79tTZLjRp/4ZyqMDNtY8vIY54aLcAm9kdnWFbR7Te86f0VZq3mPXpuFiDn
 O5gcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Sat, 12 Sep 2026 09:34:44 +0200, Karl Mehltretter wrote:
> netfs: Document the remote size member and its accessors

Applied to the vfs-7.4.netfs branch of the vfs/vfs.git tree.
Patches in the vfs-7.4.netfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.4.netfs

[1/1] netfs: Document the remote size member and its accessors
      https://git.kernel.org/vfs/vfs/c/afdf722ab983

